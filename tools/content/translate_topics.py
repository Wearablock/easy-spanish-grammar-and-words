#!/usr/bin/env python3
"""Translate topic theory (topics_en.json) into the app's content languages with the Claude Code CLI.

    python3 tools/content/translate_topics.py --plan                 how many topics each language still lacks
    python3 tools/content/translate_topics.py --locale ru --limit 3  one small batch first (prints the time)
    python3 tools/content/translate_topics.py                        everything missing, 4 batches in parallel

A topic counts as missing when topics_<code>.json has no file, or its theory is still the English one.
Spanish stays Spanish: title_es, every vocab «word» and «example» must come back unchanged, and the markdown
must keep the same shape (headings, table rows, bold pairs) — otherwise that topic is skipped and printed.
Results are written into topics_<code>.json (a full file: English fills whatever is not translated yet).
"""
import concurrent.futures as cf, json, os, re, subprocess, sys, threading, time

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
T = os.path.join(ROOT, "assets", "data", "topics")
LANG = {"ja": "Japanese", "zh-Hans": "Simplified Chinese", "zh-Hant": "Traditional Chinese (Taiwan)", "de": "German",
        "fr": "French", "es": "Spanish (as the explanation language for Spanish speakers)", "pt": "Brazilian Portuguese",
        "it": "Italian", "ru": "Russian", "ar": "Arabic", "th": "Thai", "vi": "Vietnamese", "id": "Indonesian"}
BATCH = 3
lock = threading.Lock()

PROMPT = """You translate lesson pages of a Spanish-learning app for {lang} speakers. Return ONLY a JSON object {{"<id>": {{...}}, ...}} with the same ids and the same keys.
Translate into natural {lang}: "title", "theory" (markdown), every item of "key_points", and in "vocab_list" only "meaning" and "example_meaning".
Copy EXACTLY, character by character: "title_es", every vocab "word" and "example", and every Spanish word, phrase or example sentence inside the theory and key points (keep accents and ¿ ¡).
Keep the markdown exactly in shape: same headings (#), same tables (same rows and | columns), same bullet lines, same **bold** pairs around the same words, same line breaks. Do not add or drop content. Never mention any exam.
Items:
{items}"""

def path(code): return os.path.join(T, f"topics_{code}.json")
def load(p): return json.load(open(p, encoding="utf-8"))

def missing(code, en):
    have = load(path(code)) if os.path.exists(path(code)) else {}
    return [k for k in en if k not in have or have[k].get("theory") == en[k].get("theory")]

def shape(t):
    th = t.get("theory", "")
    return (len(re.findall(r"^#+ ", th, re.M)), th.count("\n|"), th.count("**"), len(t.get("key_points", [])), len(t.get("vocab_list", [])))

def ok(src, out):
    if not isinstance(out, dict) or not out.get("theory") or not out.get("title"): return "empty"
    if out.get("title_es") != src.get("title_es"): return "title_es changed"
    for a, b in zip(src.get("vocab_list", []), out.get("vocab_list", [])):
        if a.get("word") != b.get("word") or a.get("example") != b.get("example"): return "vocab Spanish changed"
    if shape(src) != shape(out): return f"markdown shape {shape(src)} → {shape(out)}"
    if "DELE" in json.dumps(out, ensure_ascii=False): return "mentions DELE"
    return None

def call(code, batch, en):
    items = {k: en[k] for k in batch}
    r = subprocess.run(["claude", "-p", "--output-format", "json", "--model", "sonnet"],
                       input=PROMPT.format(lang=LANG[code], items=json.dumps(items, ensure_ascii=False, indent=1)),
                       capture_output=True, text=True, timeout=1800)
    text = json.loads(r.stdout)["result"]
    return json.JSONDecoder().raw_decode(text[text.index("{"):])[0]

def apply(code, batch, out, en, indent):
    good = 0
    with lock:
        data = load(path(code)) if os.path.exists(path(code)) else json.loads(json.dumps(en))
        for k in batch:
            why = ok(en[k], out.get(k))
            if why: print(f"  ✕ {code} {k}: {why}", flush=True); continue
            data[k] = {**en[k], **out[k]}; good += 1
        open(path(code), "w", encoding="utf-8").write(json.dumps(data, ensure_ascii=False, indent=indent))
    return good

def main():
    raw = open(path("en"), encoding="utf-8").read(); en = json.loads(raw)
    indent = len(re.match(r'\{\n( +)"', raw)[1])
    codes = [sys.argv[sys.argv.index("--locale") + 1]] if "--locale" in sys.argv else list(LANG)
    limit = int(sys.argv[sys.argv.index("--limit") + 1]) if "--limit" in sys.argv else None
    jobs = {c: missing(c, en)[:limit] if limit else missing(c, en) for c in codes}
    if "--plan" in sys.argv:
        print({c: len(v) for c, v in jobs.items()}, "total", sum(map(len, jobs.values()))); return
    tasks = [(c, ids[i:i + BATCH]) for c, ids in jobs.items() for i in range(0, len(ids), BATCH)]
    workers = int(sys.argv[sys.argv.index("--workers") + 1]) if "--workers" in sys.argv else 4
    print(f"{len(tasks)} batches · {workers} in parallel", flush=True)
    t0, done, total = time.time(), 0, 0
    with cf.ThreadPoolExecutor(max_workers=workers) as ex:
        futs = {ex.submit(call, c, b, en): (c, b) for c, b in tasks}
        for i, f in enumerate(cf.as_completed(futs), 1):
            c, b = futs[f]
            try: g = apply(c, b, f.result(), en, indent)
            except Exception as e: g = 0; print(f"  ✕ batch {c} {b[0]}…: {e}", flush=True)
            done += g; total += len(b)
            el = time.time() - t0
            print(f"[{i}/{len(tasks)}] {c} +{g}/{len(b)} · {el/60:.1f} min · about {el/i*(len(tasks)-i)/60:.0f} min left", flush=True)
    print(f"done: {done}/{total} topics · {(time.time()-t0)/60:.1f} min")

if __name__ == "__main__":
    main()
