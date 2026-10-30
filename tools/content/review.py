#!/usr/bin/env python3
"""Content review of the English master with the Claude Code CLI — before translating a LV.

    python3 tools/content/review.py LV1        → content-src/review-LV1.json  (only flagged questions)
    ES_TOPICS=ch_vocab_a1_06,ch_gram_a1_07 ES_TAG=1030 python3 tools/content/review.py LV2   → only those topics · review-LV2-1030.json

LV = slice of the daily path (question_selector._orderForDailyPath: A1→B1, grammar/vocab alternating), 11 topics each.
The reviewer flags: wrong answer · two correct options · Spanish error · misleading explanation · level mismatch.
Nothing is changed automatically — a person decides each flag.
"""
import json, os, re, subprocess, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import master as M

ORDER = {"a1": 1, "a2": 2, "b1": 3}


def path_topics():
    topics = {}
    for lv in M.LEVELS:
        for qid, m in M.meta(lv).items():
            topics.setdefault(m["topic_id"], []).append((lv, qid))
    def key(t):
        p = t.split("_")
        m = re.match(r"(\d+)([a-z]?)$", p[-1])   # 01b (10-31 split topic) right after 01 — same rule as the app
        no = int(m[1]) * 10 + (ord(m[2]) - 96 if m[2] else 0) if m else 0
        return (ORDER.get(p[2], 9), no, 1 if "_vocab_" in t else 0)
    return [(t, topics[t]) for t in sorted(topics, key=key) if t.split("_")[2] in ORDER]


def lv_slice(n, size=11):
    """LV1~LV8 = 11 topics each · LV9 = the rest (14) — A1~B1 is 102 topics"""
    t = path_topics()
    t = t[(n - 1) * size:] if n == 9 else t[(n - 1) * size: n * size]
    only = os.environ.get("ES_TOPICS")       # 10-30 daily 2 topics: ES_TOPICS=ch_vocab_a1_06,ch_gram_a1_07
    return [x for x in t if x[0] in only.split(",")] if only else t


def tag(n):
    """file name part: LV2 · or LV2-1030 when ES_TAG=1030 (one record per day, not overwritten)"""
    return f"LV{n}" + (f"-{os.environ['ES_TAG']}" if os.environ.get("ES_TAG") else "")


PROMPT = """You are a strict Spanish teacher reviewing quiz items for learners (CEFR {cefr}). For each item check:
1) the "correct" answer is really correct, 2) no "wrong" option is also correct, 3) the Spanish has no errors,
4) the explanation is right and not misleading, 5) the item fits the level.
Return ONLY JSON: [{{"id": ..., "problem": "<short>", "fix": "<what to change>"}}] for items with a REAL problem. [] if none.
Items:
{items}"""


def main():
    n = int(sys.argv[1].upper().replace("LV", ""))
    flagged = []
    for topic, qs in lv_slice(n):
        items = []
        for lv, qid in qs:
            e = M.load(os.path.join(M.MASTER, f"{lv}.json"))[qid]["entry"]
            items.append({"id": qid, "question": e["question"], "correct": e["correct"], "wrong": e.get("wrong", []), "explanation": e.get("explanation", "")})
        r = subprocess.run(["claude", "-p", "--output-format", "json", "--model", "sonnet"],
                           input=PROMPT.format(cefr=topic.split("_")[2].upper(), items=json.dumps(items, ensure_ascii=False, indent=1)),
                           capture_output=True, text=True, timeout=600)
        text = json.loads(r.stdout)["result"]
        got = json.JSONDecoder().raw_decode(text[text.index("["):])[0]
        for g in got:
            g["topic"] = topic
        flagged += got
        print(f"{topic}: {len(qs)} checked · {len(got)} flagged", flush=True)
    out = os.path.join(M.ROOT, "content-src", f"review-{tag(n)}.json")
    M.save(out, flagged)
    print(f"→ {out} · {len(flagged)} flagged")


if __name__ == "__main__":
    main()
