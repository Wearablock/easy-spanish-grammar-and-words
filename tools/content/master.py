#!/usr/bin/env python3
"""One Spanish master per question id — every locale must ask the same Spanish question.

    python3 tools/content/master.py build      majority vote across 15 locales → content-src/master/<level>.json
    python3 tools/content/master.py repair     fix locale files mechanically where possible (Spanish-only parts)
                                               → content-src/retranslate.json lists the rest (need translation)
    python3 tools/content/master.py check      every locale vs master — used by publish.py (exit 1 on mismatch)

Why (2026-10-29): each locale file carried its own copy of the Spanish question. They drifted apart —
ru vocab_c1 was a different question set, it files had Japanese questions, ja dropped the Spanish "a"
(«ven a visitarnos» → «ven visitarnos»), th translated inside Spanish words («sen10cia»).

What counts as "the Spanish part" depends on the question type (meta/<level>.json):
    fill_blank · conjugation   sentence (without the trailing hint) + correct + wrong   → all Spanish
    translation es_to_ko       question is Spanish                                     (options are the locale)
    translation ko_to_es       correct + wrong are Spanish                             (question is the locale)
    meaning · context          the quoted Spanish term in the question                 (options are the locale)
"""
import collections, glob, json, os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
Q = os.path.join(ROOT, "assets", "data", "questions")
MASTER = os.path.join(ROOT, "content-src", "master")
RETRANSLATE = os.path.join(ROOT, "content-src", "retranslate.json")
REF_ORDER = ["en", "fr", "pt", "de", "it", "ko", "ja", "zh", "zh-Hant", "ru", "vi", "id", "th", "ar", "es"]
LOCALES = sorted(d for d in os.listdir(Q) if os.path.isdir(os.path.join(Q, d)) and d != "meta")
LEVELS = sorted(os.path.basename(f)[:-5] for f in glob.glob(os.path.join(Q, "meta", "*.json")))
HINT = re.compile(r"(\s*[(（][^()（）]*[)）])+\s*$")   # one or more trailing hints «(tener) (They are…)»
QUOTED = re.compile(r"['‘’\"“”«»「」『』]([^'‘’\"“”«»「」『』]{2,80})['‘’\"“”«»「」『』]")


def load(path):
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def save(path, data):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        f.write(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def meta(level):
    m = load(os.path.join(Q, "meta", f"{level}.json"))
    items = m if isinstance(m, list) else m.get("questions", m)
    if isinstance(items, dict):
        items = [dict(id=k, **v) for k, v in items.items()]
    return {q["id"]: q for q in items}


def split_hint(question):
    """«Si tú ___ tiempo. (tener)» → («Si tú ___ tiempo.», « (tener)»)"""
    m = HINT.search(question)
    return (question[: m.start()].strip(), question[m.start():]) if m else (question.strip(), "")


ES_W = set("el la los las un una unos unas es son está están estoy soy de del que en y por para con no se mi tu su al lo le muy más yo él ella nosotros hay".split())
EN_W = set("the a an is are am was were of to in and i you he she it we they my your his her this that there on at with not".split())


try:
    with open("/usr/share/dict/words") as _f:
        EN_DICT = {w.strip().lower() for w in _f}
except OSError:
    EN_DICT = set()


def spanish_words(text):
    """Words that are Spanish, not English — «dejar de + infinitive» → [dejar, de]"""
    return [w for w in re.findall(r"[a-záéíóúüñ]+", text.lower())
            if w in ES_W or re.search(r"[áéíóúüñ]", w) or (len(w) > 2 and w not in EN_DICT)]


def spanish_score(text):
    """> 0 looks Spanish, < 0 looks English — used to tell which side of a translation item is Spanish."""
    words = re.findall(r"[a-záéíóúüñ]+", text.lower())
    return sum(w in ES_W for w in words) - sum(w in EN_W for w in words) + 2 * bool(re.search(r"[áéíóúñ¿¡]", text))


def norm(s):
    return re.sub(r"\s+", " ", s.strip().lower())


def spanish_term(question):
    # an English quoted word («how do you say 'you'?») is not the Spanish part
    hits = [h for h in QUOTED.findall(question) if re.search(r"[a-záéíóúüñ]{2}", h.lower()) and spanish_score(h) >= 0
            and not (len(h.split()) <= 2 and h.lower().strip() in EN_W)]
    return norm(hits[0]) if hits else None


def same(kind, direction, q, ref, side=None):
    """Does this locale entry ask the same Spanish question as the master entry?
    For translation items [side] (question/options — measured, see build) wins over the meta label."""
    if kind == "translation" and side:
        direction = "es_to_ko" if side == "question" else "ko_to_es"
    if kind in ("meaning", "context"):
        term = spanish_term(ref["question"])
        if term is None:
            return True
        # quoted terms can mix in English («dejar de + infinitive» · «mixed conditional») — only the Spanish words count
        words = spanish_words(term)
        text = norm(q["question"])
        return term in text or not words or sum(w in text for w in words) >= 0.7 * len(words)
    return sig(kind, direction, q) == sig(kind, direction, ref)


def sig(kind, direction, q):
    """The Spanish part of one locale entry — equal across locales when they ask the same question."""
    if kind in ("fill_blank", "conjugation"):
        return (norm(split_hint(q["question"])[0]), norm(q["correct"]), tuple(sorted(norm(w) for w in q.get("wrong", []))))
    if kind == "translation":
        if direction == "es_to_ko":
            return (norm(split_hint(q["question"])[0]),)
        return (norm(q["correct"]), tuple(sorted(norm(w) for w in q.get("wrong", []))))
    term = spanish_term(q["question"])
    return (term,) if term else None


def build():
    out_total, no_major = 0, 0
    for level in LEVELS:
        m = meta(level)
        data = {l: load(os.path.join(Q, l, f"{level}.json")) for l in LOCALES if os.path.exists(os.path.join(Q, l, f"{level}.json"))}
        master = {}
        for qid, mq in m.items():
            kind, direction = mq.get("type"), mq.get("translation_dir")
            side = None
            if kind == "translation":
                present = [d[qid] for d in data.values() if qid in d]
                qs = collections.Counter(norm(split_hint(x["question"])[0]) for x in present)
                cs = collections.Counter(norm(x["correct"]) for x in present)
                # many locales copied the English sentence untranslated — «identical everywhere» is not enough,
                # the Spanish side is the one that reads as Spanish
                q_top, c_top = qs.most_common(1)[0][0], cs.most_common(1)[0][0]
                side = "question" if spanish_score(q_top) > spanish_score(c_top) else "options"
                if (qs if side == "question" else cs).most_common(1)[0][1] < 0.5 * len(present):
                    side = None
                if side:
                    direction = "es_to_ko" if side == "question" else "ko_to_es"
                    want = qs.most_common(1)[0][0] if side == "question" else cs.most_common(1)[0][0]
                    pick = lambda x: norm(split_hint(x["question"])[0]) if side == "question" else norm(x["correct"])
                    ref = next((l for l in REF_ORDER if l in data and qid in data[l] and pick(data[l][qid]) == want), None)
                    if ref:
                        master[qid] = {"type": kind, "translation_dir": direction, "spanish_side": side, "ref": ref,
                                       "votes": "70%+", "spanish": [want], "entry": data[ref][qid]}
                        out_total += 1
                        continue
            sigs = {l: sig(kind, direction, d[qid]) for l, d in data.items() if qid in d}
            usable = {l: s for l, s in sigs.items() if s}
            if not usable:
                if "en" in data and qid in data["en"]:   # no Spanish part to vote on — English is the master
                    master[qid] = {"type": kind, "translation_dir": direction, "ref": "en", "votes": "0/0",
                                   "spanish": [], "entry": data["en"][qid]}
                    out_total += 1
                continue
            top, n = collections.Counter(usable.values()).most_common(1)[0]
            # English is the authoring language — it is the master unless it is clearly the odd one out
            # (≥5 votes and ≥60% agree on something else). Small votes (1/1 · 2/3) picked broken ru/it files as master.
            clear = n >= 5 and n >= 0.6 * len(usable)
            if "en" in data and qid in data["en"] and (usable.get("en") == top or not clear):
                ref = "en"
            else:
                ref = next((l for l in ("es",) if usable.get(l) == top), None) or next(l for l, s in usable.items() if s == top)
            no_major += not clear
            master[qid] = {"type": kind, "translation_dir": direction, "ref": ref, "votes": f"{n}/{len(usable)}",
                           "spanish": list(top) if not isinstance(top, str) else [top], "entry": data[ref][qid]}
            out_total += 1
        save(os.path.join(MASTER, f"{level}.json"), master)
        raw = load(os.path.join(Q, "meta", f"{level}.json"))
        items = raw if isinstance(raw, list) else raw.get("questions", raw)
        fixed = 0
        for item in (items.values() if isinstance(items, dict) else items):
            mid = item.get("id") or next((k for k, v in items.items() if v is item), None) if isinstance(items, dict) else item.get("id")
            mq = master.get(mid) if mid else None
            if mq and mq.get("spanish_side") and item.get("translation_dir") != mq["translation_dir"]:
                item["translation_dir"] = mq["translation_dir"]; fixed += 1
        if fixed:
            save(os.path.join(Q, "meta", f"{level}.json"), raw); print(f"  meta {level}: translation_dir fixed ×{fixed}")
    print(f"master: {out_total} questions · {no_major} without a clear majority (check by hand)")


def repair():
    fixed, queue = collections.Counter(), collections.defaultdict(list)
    for level in LEVELS:
        master = load(os.path.join(MASTER, f"{level}.json"))
        for l in LOCALES:
            p = os.path.join(Q, l, f"{level}.json")
            if not os.path.exists(p):
                continue
            d, changed = load(p), False
            for qid, mq in master.items():
                kind, direction, ref = mq["type"], mq["translation_dir"], mq["entry"]
                q = d.get(qid)
                if q is None:
                    queue[l].append([level, qid, "missing"]); continue
                if same(kind, direction, q, ref, mq.get("spanish_side")):
                    continue
                if kind == "translation":
                    queue[l].append([level, qid, "all"]); continue
                if kind in ("fill_blank", "conjugation"):
                    same_answer = norm(q["correct"]) == norm(ref["correct"])
                    q["question"] = split_hint(ref["question"])[0] + split_hint(q["question"])[1]
                    q["correct"], q["wrong"] = ref["correct"], list(ref.get("wrong", []))
                    changed = True; fixed[l] += 1
                    if not same_answer:   # it was a different question — its explanation explains something else
                        queue[l].append([level, qid, "explanation"])
                elif kind == "translation" and direction == "es_to_ko":
                    q["question"] = split_hint(ref["question"])[0] + split_hint(q["question"])[1]
                    changed = True; fixed[l] += 1
                    queue[l].append([level, qid, "check-options"])
                elif kind == "translation":
                    q["correct"], q["wrong"] = ref["correct"], list(ref.get("wrong", []))
                    changed = True; fixed[l] += 1
                    queue[l].append([level, qid, "question+explanation"])
                else:
                    queue[l].append([level, qid, "all"])
            if changed:
                save(p, d)
    save(RETRANSLATE, queue)
    print("mechanically fixed:", dict(fixed.most_common()))
    print("need translation:", {l: len(v) for l, v in sorted(queue.items(), key=lambda x: -len(x[1]))})


def check():
    bad = collections.Counter()
    hand = set(load(os.path.join(ROOT, "content-src", "review-by-hand.json"))["ids"])
    print(f"review by hand (not blocking): {sorted(hand)}")
    for level in LEVELS:
        master = load(os.path.join(MASTER, f"{level}.json"))
        for l in LOCALES:
            p = os.path.join(Q, l, f"{level}.json")
            if not os.path.exists(p):
                continue
            d = load(p)
            for qid, mq in master.items():
                if qid in hand:
                    continue
                q = d.get(qid)
                if q is None or not same(mq["type"], mq["translation_dir"], q, mq["entry"], mq.get("spanish_side")):
                    bad[l] += 1
    total = sum(bad.values())
    print("consistency vs master:", "all locales match" if not total else dict(bad.most_common()))
    return total


if __name__ == "__main__":
    cmd = sys.argv[1] if len(sys.argv) > 1 else "check"
    if cmd == "build":
        build()
    elif cmd == "repair":
        repair()
    else:
        sys.exit(1 if check() else 0)
