#!/usr/bin/env python3
"""Apply a review's fixes to the English master (assets/data/questions/en) — proposal first, then write.

    python3 tools/content/fix_master.py LV1 --propose   → content-src/fix-LV1.json (corrected entries, nothing written)
    python3 tools/content/fix_master.py LV1 --apply     → writes en/<level>.json · run master.py build afterwards
"""
import json, os, subprocess, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import master as M

PROMPT = """Fix these Spanish-learning quiz items (English UI) according to each "fix" note. Keep the same structure and
the same number of wrong options. Keep Spanish correct. Keep the explanation's line format ("- " bullets).
Return ONLY JSON: {{"<id>": {{"question": ..., "correct": ..., "wrong": [...], "explanation": ..., "hint": ...}}}}
Items:
{items}"""


def main():
    lvname = sys.argv[1].upper()
    review = M.load(os.path.join(M.ROOT, "content-src", f"review-{lvname}.json"))
    out = os.path.join(M.ROOT, "content-src", f"fix-{lvname}.json")
    where = {}
    for lv in M.LEVELS:
        for qid in M.load(os.path.join(M.Q, "en", f"{lv}.json")):
            where[qid] = lv
    if "--propose" in sys.argv:
        items = []
        for f in review:
            e = M.load(os.path.join(M.Q, "en", f"{where[f['id']]}.json"))[f["id"]]
            items.append({"id": f["id"], **{k: e.get(k) for k in ("question", "correct", "wrong", "explanation", "hint")},
                          "problem": f["problem"], "fix": f["fix"]})
        r = subprocess.run(["claude", "-p", "--output-format", "json", "--model", "sonnet"],
                           input=PROMPT.format(items=json.dumps(items, ensure_ascii=False, indent=1)),
                           capture_output=True, text=True, timeout=600)
        text = json.loads(r.stdout)["result"]
        M.save(out, json.JSONDecoder().raw_decode(text[text.index("{"):])[0])
        print(f"→ {out}")
    elif "--apply" in sys.argv:
        fixes = M.load(out)
        for qid, new in fixes.items():
            p = os.path.join(M.Q, "en", f"{where[qid]}.json")
            d = M.load(p)
            d[qid].update({k: v for k, v in new.items() if k in ("question", "correct", "wrong", "explanation", "hint")})
            assert d[qid]["correct"] not in d[qid]["wrong"], qid
            M.save(p, d)
        print(f"applied {len(fixes)} fixes to en")


if __name__ == "__main__":
    main()
