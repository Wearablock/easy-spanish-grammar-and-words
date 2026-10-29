#!/usr/bin/env python3
"""Publish learning data to Cloudflare so the app picks it up without an app update.

    python3 tools/content/publish.py --check     validate only (no build, no deploy)
    python3 tools/content/publish.py             validate → build content-cdn/public → wrangler deploy

Source of truth: the Spanish part of every question lives once in content-src/master/ (master.py);
the locale files in assets/data/ carry only the learner's language. Publishing is refused if any locale
asks a different Spanish question than the master.
The next app build bundles the same files, so bundled and served data never drift apart.
"""
import hashlib, json, os, shutil, subprocess, sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
SRC = os.path.join(ROOT, "assets", "data")
OUT = os.path.join(ROOT, "content-cdn", "public")
MIN_APP = "1.5.0"   # first app version that reads remote data
SCHEMA = 1
WRANGLER = os.path.expanduser("~/Projects/hub/domocozi/web/node_modules/.bin/wrangler")


def files():
    for base, _, names in os.walk(SRC):
        for n in sorted(names):
            if n.endswith(".json") and n != "placeholder.json":
                full = os.path.join(base, n)
                yield os.path.relpath(full, SRC), full


def check(rel, data):
    """Same rules the app applies (remote_content_service.dart _looksRight) plus a few more."""
    errs = []
    if rel.startswith("questions/") and not rel.startswith("questions/meta/"):
        if not isinstance(data, dict) or not data:
            return ["empty or not an object"]
        for qid, q in data.items():
            if not isinstance(q, dict) or not isinstance(q.get("question"), str) or not isinstance(q.get("correct"), str):
                errs.append(f"{qid}: question/correct missing")
            elif q.get("wrong") is not None and q["correct"] in q["wrong"]:
                errs.append(f"{qid}: correct answer is also in wrong options")
    elif not isinstance(data, (dict, list)):
        errs.append("not an object or list")
    return errs


def main():
    manifest, bad = {}, 0
    for rel, full in files():
        raw = open(full, "rb").read()
        try:
            data = json.loads(raw)
        except ValueError as e:
            print(f"❌ {rel}: invalid JSON ({e})"); bad += 1; continue
        errs = check(rel, data)
        for e in errs[:5]:
            print(f"❌ {rel}: {e}")
        bad += bool(errs)
        manifest[rel] = {"sha256": hashlib.sha256(raw).hexdigest(), "bytes": len(raw)}
    print(f"{len(manifest)} files · {bad} with problems")
    # every locale must ask the same Spanish question as the master (tools/content/master.py) — 10-29
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    import master
    if master.check():
        bad += 1
        print("❌ some locales ask a different question than the master — run master.py repair / translate.py")
    if bad:
        sys.exit("🔴 fix the files above — nothing published")
    if "--check" in sys.argv:
        return
    shutil.rmtree(OUT, ignore_errors=True)
    for rel, full in files():
        dst = os.path.join(OUT, "data", rel)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.copyfile(full, dst)
    with open(os.path.join(OUT, "manifest.json"), "w") as f:
        json.dump({"schema": SCHEMA, "min_app": MIN_APP, "files": manifest}, f, separators=(",", ":"))
    with open(os.path.join(OUT, "_headers"), "w") as f:
        f.write("/manifest.json\n  Cache-Control: no-cache\n/data/*\n  Cache-Control: public, max-age=300\n")
    subprocess.run([WRANGLER, "deploy"], cwd=os.path.join(ROOT, "content-cdn"), check=True)


if __name__ == "__main__":
    main()
