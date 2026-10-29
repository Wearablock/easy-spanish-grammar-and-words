#!/usr/bin/env python3
"""Translate questions from the master (English) into each locale with the Claude Code CLI (no API key).

    python3 tools/content/translate.py --plan              what would be translated (queue + English-mixed fields)
    python3 tools/content/translate.py --locale it --limit 25   try one small batch first
    python3 tools/content/translate.py                     everything, 4 batches in parallel
    python3 tools/content/translate.py --lv 1              regenerate one LV of the daily path (all 14 locales)

Each batch (25 questions) goes to `claude -p` with the master English entry and the rules for its type.
The result is accepted only if the Spanish part is untouched (master.same), the correct answer is not
among the wrong ones and nothing is empty — otherwise that question is skipped and printed.
Spanish stays Spanish. Only the learner's language parts are translated:
    fill_blank · conjugation   hint in parentheses · explanation
    translation ko_to_es       question (the sentence to translate) · explanation
    translation es_to_ko       correct · wrong (meanings in the locale) · explanation
    meaning · context          question (quoted Spanish kept) · correct · wrong · explanation · hint
"""
import concurrent.futures as cf, json, os, re, subprocess, sys, threading

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import master as M

LANG = {"ko": "Korean", "ja": "Japanese", "zh": "Simplified Chinese", "zh-Hant": "Traditional Chinese (Taiwan)",
        "es": "Spanish (as the explanation language for Spanish speakers)", "pt": "Brazilian Portuguese",
        "fr": "French", "de": "German", "it": "Italian", "ru": "Russian", "ar": "Arabic", "th": "Thai",
        "vi": "Vietnamese", "id": "Indonesian"}
BATCH = 20
SRC = {"en": "English", "fr": "French", "pt": "Portuguese", "de": "German", "it": "Italian", "ko": "Korean", "ja": "Japanese",
       "zh": "Simplified Chinese", "zh-Hant": "Traditional Chinese", "ru": "Russian", "vi": "Vietnamese", "id": "Indonesian",
       "th": "Thai", "ar": "Arabic", "es": "Spanish"}
EN_WORDS = set("the and is are of what which word mean means correct error identify sentence choose to at for with".split())
lock = threading.Lock()


# 10-29 — the it file still had Japanese questions that passed every other check (same Spanish term)
SCRIPT = {"ja": r"[\u3040-\u30ff\u4e00-\u9fff]", "zh": r"[\u4e00-\u9fff]", "zh-Hant": r"[\u4e00-\u9fff]",
          "ko": r"[\uac00-\ud7a3]", "ru": r"[\u0400-\u04ff]", "th": r"[\u0e00-\u0e7f]", "ar": r"[\u0600-\u06ff]"}
FOREIGN = r"[\u3040-\u30ff\u4e00-\u9fff\uac00-\ud7a3\u0400-\u04ff\u0e00-\u0e7f\u0600-\u06ff]"


def wrong_script(locale, q):
    text = " ".join(q.get(f) or "" for f in ("question", "explanation"))
    if locale in SCRIPT:
        own = re.findall(SCRIPT[locale], text)
        other = re.findall(FOREIGN, re.sub(SCRIPT[locale], "", text))
        return not own or len(other) > len(own)
    return bool(re.search(FOREIGN, text))   # Latin-script languages: no CJK · Hangul · Cyrillic · Thai · Arabic


EN_MORE = set("if would been have has had when where who this that was were will does did they their its perhaps should could hadn't isn't doesn't".split())
SLASH = re.compile(r"\b(il/la|der/die/das|é/está|es/está)\b", re.I)   # word-by-word machine translation leaves these


# words that are English and never Spanish — for CJK · Hangul · Thai · Arabic · Cyrillic locales
EN_ONLY = set("the of and is are this that what which between difference used uses express expresses meaning describes "
              "describe tense sentence word words when how why with without about".split())
STRONG_EN = set("the what which does would should could hadn't isn't doesn't been were when where".split())


def english_mixed(q, locale=None):
    for field in ("question", "explanation", "hint"):
        raw0 = q.get(field) or ""
        outside = re.sub(r"['‘’\"«»「」“”][^'‘’\"«»「」“”]*['‘’\"«»「」“”]", " ", raw0)
        words = re.findall(r"[A-Za-z']+", outside.lower())
        if any(w in STRONG_EN for w in words):
            return True
        if locale in SCRIPT and len([w for w in words if w in EN_ONLY]) >= 2:
            return True
    for field in ("question", "explanation", "hint"):
        raw = q.get(field) or ""
        if SLASH.search(raw):
            return True
        t0 = re.sub(r"['‘’\"«»「」][^'‘’\"«»「」]*['‘’\"«»「」]", " ", raw)
        if len([w for w in re.findall(r"[A-Za-z']+", t0.lower()) if w in EN_MORE]) >= 2:
            return True
    for field in ("question", "explanation", "hint"):
        t = re.sub(r"['‘’\"«»「」][^'‘’\"«»「」]*['‘’\"«»「」]", " ", q.get(field) or "")
        if len([w for w in re.findall(r"[A-Za-z]+", t.lower()) if w in EN_WORDS]) >= 2:
            return True
    return False


def plan():
    queue = M.load(M.RETRANSLATE)
    jobs = {}
    for l in M.LOCALES:
        if l == "en":
            continue
        ids = {(lv, qid) for lv, qid, _ in queue.get(l, [])}
        for lv in M.LEVELS:
            for qid, q in M.load(os.path.join(M.Q, l, f"{lv}.json")).items():
                if english_mixed(q, l) or wrong_script(l, q):
                    ids.add((lv, qid))
        if ids:
            jobs[l] = sorted(ids)
    return jobs


PROMPT = """You translate Spanish-learning quiz items for {lang} speakers. Return ONLY a JSON object: {{"<id>": {{...}}, ...}} with the same ids.
Each input item is the master: id, type, spanish_side, source_language (the language of its non-Spanish text), question, correct, wrong, explanation, hint.
CRITICAL: answer EVERY id. Spanish text must stay EXACTLY as given — copy it character by character, including inside quotes (never translate or change Spanish words, accents or punctuation):
- fill_blank / conjugation: keep "question" Spanish sentence as is, but translate a trailing hint in parentheses into {lang}; keep "correct" and "wrong" exactly; translate "explanation" and "hint".
- translation with spanish_side "options": the question is a sentence in source_language — translate it into natural {lang}; keep "correct" and "wrong" (Spanish) exactly; translate "explanation".
- translation with spanish_side "question": keep "question" (Spanish) exactly; translate "correct" into natural {lang}; translate each "wrong" option into {lang} keeping the same mistake it represents (wrong person, time, meaning); translate "explanation".
- meaning / context: translate "question" into {lang} keeping every quoted Spanish phrase unchanged in quotes; translate "correct" and each "wrong" into {lang}; translate "explanation" and "hint".
Keep line breaks and bullet lines ("- ...") in explanations. Write natural {lang}, not word-by-word. Return every field (question, correct, wrong, explanation, hint).
Items:
{items}"""


def call(locale, batch):
    items = []
    for lv, qid in batch:
        mq = M.load(os.path.join(M.MASTER, f"{lv}.json"))[qid]
        e = mq["entry"]
        side = mq.get("spanish_side") or ("question" if mq["translation_dir"] == "es_to_ko" else "options")
        items.append({"id": qid, "type": mq["type"], "spanish_side": side if mq["type"] == "translation" else None,
                      "source_language": SRC.get(mq["ref"], "English"), "question": e["question"],
                      "correct": e["correct"], "wrong": e.get("wrong", []), "explanation": e.get("explanation", ""), "hint": e.get("hint")})
    prompt = PROMPT.format(lang=LANG[locale], items=json.dumps(items, ensure_ascii=False, indent=1))
    r = subprocess.run(["claude", "-p", "--output-format", "json", "--model", "sonnet"], input=prompt,
                       capture_output=True, text=True, timeout=900)
    text = json.loads(r.stdout)["result"]
    return json.JSONDecoder().raw_decode(text[text.index("{"):])[0]


def apply(locale, batch, out):
    ok = bad = 0
    by_level = {}
    for lv, qid in batch:
        by_level.setdefault(lv, []).append(qid)
    with lock:
        for lv, qids in by_level.items():
            path = os.path.join(M.Q, locale, f"{lv}.json")
            data, master = M.load(path), M.load(os.path.join(M.MASTER, f"{lv}.json"))
            for qid in qids:
                t, mq = out.get(qid), master[qid]
                if not isinstance(t, dict) or not all(isinstance(t.get(k), str) and t.get(k).strip() for k in ("question", "correct")):
                    bad += 1; print(f"  ✕ {locale} {qid}: missing fields"); continue
                cand = dict(data.get(qid, {}))
                cand.update({k: t[k] for k in ("question", "correct", "wrong", "explanation", "hint") if k in t})
                cand["wrong"] = [w for w in cand.get("wrong", []) if isinstance(w, str)]
                if not M.same(mq["type"], mq["translation_dir"], cand, mq["entry"], mq.get("spanish_side")):
                    bad += 1; print(f"  ✕ {locale} {qid}: Spanish part changed"); continue
                if cand["correct"] in cand["wrong"] or len(cand["wrong"]) != len(mq["entry"].get("wrong", [])):
                    bad += 1; print(f"  ✕ {locale} {qid}: options broken"); continue
                data[qid] = cand; ok += 1
            M.save(path, data)
    return ok, bad


def lv_jobs(n):
    """LV n of the daily path — every question in it, every locale (regenerate, not just the flagged ones)"""
    import review
    ids = [x for _, qs in review.lv_slice(n) for x in qs]
    return {l: sorted(ids) for l in M.LOCALES if l != "en"}


def main():
    jobs = lv_jobs(int(sys.argv[sys.argv.index("--lv") + 1])) if "--lv" in sys.argv else plan()
    if "--locale" in sys.argv:
        only = sys.argv[sys.argv.index("--locale") + 1]
        jobs = {only: jobs.get(only, [])}
    if "--plan" in sys.argv:
        print({l: len(v) for l, v in sorted(jobs.items(), key=lambda x: -len(x[1]))}, "total", sum(map(len, jobs.values())))
        return
    limit = int(sys.argv[sys.argv.index("--limit") + 1]) if "--limit" in sys.argv else None
    tasks = []
    for l, ids in jobs.items():
        ids = ids[:limit] if limit else ids
        tasks += [(l, ids[i:i + BATCH]) for i in range(0, len(ids), BATCH)]
    print(f"{len(tasks)} batches")
    total_ok = total_bad = 0
    with cf.ThreadPoolExecutor(max_workers=4) as ex:
        futs = {ex.submit(call, l, b): (l, b) for l, b in tasks}
        for i, f in enumerate(cf.as_completed(futs), 1):
            l, b = futs[f]
            try:
                ok, bad = apply(l, b, f.result())
            except Exception as e:
                ok, bad = 0, len(b); print(f"  ✕ batch {l}: {e}")
            total_ok += ok; total_bad += bad
            print(f"[{i}/{len(tasks)}] {l} +{ok} ✕{bad}", flush=True)
    print(f"done: {total_ok} translated · {total_bad} skipped")


if __name__ == "__main__":
    main()
