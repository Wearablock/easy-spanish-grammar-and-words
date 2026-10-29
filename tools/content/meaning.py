#!/usr/bin/env python3
"""Meaning check — does each locale say the same thing as the English master? (10-30 · the checkers only see Spanish parts)

    python3 tools/content/meaning.py --lv 1 --plan        how many items · batches (does nothing)
    python3 tools/content/meaning.py --lv 1               check + fix every locale of LV 1 (6 batches in parallel)
    python3 tools/content/meaning.py --lv 1 --locale th   one locale only

`claude -p` gets the master English entry next to the locale entry and returns ONLY the items that need a fix:
hint or explanation with a different meaning, left in English / another language, broken text, or a hint that gives
the answer away when the English one does not. A fix is accepted only if the Spanish part is untouched (master.same),
the options are intact and the locale's script is used — otherwise it is skipped and printed.
Log: content-src/meaning-LV<n>.json (id · locale · reason · before · after).
"""
import concurrent.futures as cf, json, os, subprocess, sys, threading

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import master as M
import review
from translate import LANG, wrong_script, english_mixed

BATCH = 20
lock = threading.Lock()

PROMPT = """You review a Spanish-learning quiz translated for {lang} speakers. For each id you get "master" (English, the source of truth) and "locale" (the {lang} version).
Return ONLY a JSON object {{"<id>": {{"reason": "...", "question": "...", "explanation": "...", "hint": "...", "correct": "...", "wrong": [...]}}}} containing ONLY the ids that need a fix. Return {{}} if all are fine.
An item needs a fix when the {lang} text (the hint in parentheses at the end of "question", "explanation", "hint", or for translation/meaning items "correct"/"wrong"):
- means something different from the master (e.g. adds "there", changes the instruction, wrong sentence),
- is left in English or another language, or is broken / mixed text,
- gives the answer away when the master hint does not.
Do NOT flag style differences or natural rephrasing with the same meaning. Do NOT flag a correct answer just because it is spelled the same as the Spanish (cognates like Portuguese "casa", "por favor" are correct). Never rewrite a Spanish sentence in the question.
In a fix: return every field of that item (question, correct, wrong, explanation, hint), copy all Spanish text EXACTLY character by character (the Spanish sentence, quoted Spanish words, Spanish options), translate only the {lang} parts from the master, natural {lang}. "reason" is one short English line.
Items:
{items}"""


def jobs(n, only=None):
    ids = [x for _, qs in review.lv_slice(n) for x in qs]
    locs = [l for l in M.LOCALES if l != "en" and (only is None or l == only)]
    return [(l, ids[i:i + BATCH]) for l in locs for i in range(0, len(ids), BATCH)]


def call(locale, batch):
    items = []
    for lv, qid in batch:
        e = M.load(os.path.join(M.MASTER, f"{lv}.json"))[qid]["entry"]
        q = M.load(os.path.join(M.Q, locale, f"{lv}.json"))[qid]
        pick = lambda d: {k: d.get(k) for k in ("question", "correct", "wrong", "explanation", "hint")}
        items.append({"id": qid, "master": pick(e), "locale": pick(q)})
    prompt = PROMPT.format(lang=LANG[locale], items=json.dumps(items, ensure_ascii=False, indent=1))
    r = subprocess.run(["claude", "-p", "--output-format", "json", "--model", "sonnet"], input=prompt,
                       capture_output=True, text=True, timeout=900)
    text = json.loads(r.stdout)["result"]
    return json.JSONDecoder().raw_decode(text[text.index("{"):])[0] if "{" in text else {}


def apply(locale, batch, out, log):
    ok = bad = 0
    with lock:
        for lv, qid in batch:
            t = out.get(qid)
            if not isinstance(t, dict):
                continue
            path = os.path.join(M.Q, locale, f"{lv}.json")
            data, mq = M.load(path), M.load(os.path.join(M.MASTER, f"{lv}.json"))[qid]
            before = data[qid]
            cand = dict(before)
            cand.update({k: t[k] for k in ("question", "correct", "wrong", "explanation", "hint") if k in t and t[k] is not None})
            cand["wrong"] = [w for w in cand.get("wrong", []) if isinstance(w, str)]
            why = None
            if not M.same(mq["type"], mq["translation_dir"], cand, mq["entry"], mq.get("spanish_side")):
                why = "Spanish part changed"
            elif cand["correct"] in cand["wrong"] or len(cand["wrong"]) != len(mq["entry"].get("wrong", [])):
                why = "options broken"
            elif wrong_script(locale, cand) or english_mixed(cand, locale):
                why = "wrong script / English left"
            if why:
                bad += 1; print(f"  ✕ {locale} {qid}: {why} ({t.get('reason', '')})"); continue
            data[qid] = cand; M.save(path, data); ok += 1
            log.append({"id": qid, "locale": locale, "reason": t.get("reason", ""),
                        "before": {k: before.get(k) for k in ("question", "explanation", "hint", "correct", "wrong")},
                        "after": {k: cand.get(k) for k in ("question", "explanation", "hint", "correct", "wrong")}})
    return ok, bad


def main():
    n = int(sys.argv[sys.argv.index("--lv") + 1])
    only = sys.argv[sys.argv.index("--locale") + 1] if "--locale" in sys.argv else None
    tasks = jobs(n, only)   # each item is already (level, qid)
    print(f"LV{n} · {len({q for _, b in tasks for _, q in b})} items · {len(tasks)} batches")
    if "--plan" in sys.argv:
        return
    log, done = [], 0
    with cf.ThreadPoolExecutor(max_workers=6) as ex:
        futs = {ex.submit(call, l, b): (l, b) for l, b in tasks}
        for f in cf.as_completed(futs):
            l, b = futs[f]
            try:
                ok, bad = apply(l, b, f.result(), log)
            except Exception as e:
                ok, bad = 0, 0; print(f"  ✕ batch {l}: {e}")
            done += 1
            print(f"[{done}/{len(tasks)}] {l} fixed {ok} · skipped {bad}", flush=True)
    out = os.path.join(os.path.dirname(M.MASTER), f"meaning-{review.tag(n)}.json")
    json.dump(log, open(out, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"done: {len(log)} fixed · log {out}")


if __name__ == "__main__":
    main()
