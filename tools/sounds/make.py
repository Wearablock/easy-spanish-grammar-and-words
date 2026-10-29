#!/usr/bin/env python3
"""Feedback sounds made from plain tones (10-30) — no voice, no language, nothing licensed.
    python3 tools/sounds/make.py      -> assets/sounds/{correct,wrong,speak_start,speak_end}.mp3
The same file set is meant for every language app (Easy Spanish first, the Japanese app next).
"""
import numpy as np, subprocess, wave, os, tempfile
SR = 44100
OUT = os.path.join(os.path.dirname(__file__), "..", "..", "assets", "sounds")

def tone(freq, dur, kind="sine", attack=0.005, decay=None):
    t = np.arange(int(SR * dur)) / SR
    if kind == "sine":
        w = np.sin(2 * np.pi * freq * t) + 0.25 * np.sin(2 * np.pi * 2 * freq * t)   # a little bell overtone
    else:  # soft "tri" for the wrong sound
        w = 2 / np.pi * np.arcsin(np.sin(2 * np.pi * freq * t))
    env = np.minimum(1, t / attack) * np.exp(-t / (decay or dur / 3))
    return w * env

def glide(f0, f1, dur):
    t = np.arange(int(SR * dur)) / SR
    f = np.linspace(f0, f1, t.size)
    w = np.sin(2 * np.pi * np.cumsum(f) / SR)
    return w * np.minimum(1, t / 0.004) * np.exp(-t / (dur / 2.5))

def seq(*parts, gap=0.0):
    out = []
    for i, p in enumerate(parts):
        out.append(p)
        if gap and i < len(parts) - 1:
            out.append(np.zeros(int(SR * gap)))
    return np.concatenate(out)

def save(name, x, peak_db=-4):
    x = x / np.max(np.abs(x)) * 10 ** (peak_db / 20)
    x = np.concatenate([x, np.zeros(int(SR * 0.03))])
    tmp = tempfile.NamedTemporaryFile(suffix=".wav", delete=False).name
    with wave.open(tmp, "wb") as f:
        f.setnchannels(1); f.setsampwidth(2); f.setframerate(SR)
        f.writeframes((x * 32767).astype("<i2").tobytes())
    subprocess.run(["ffmpeg", "-y", "-loglevel", "error", "-i", tmp, "-b:a", "96k", os.path.join(OUT, name + ".mp3")], check=True)
    os.remove(tmp)

# correct: two bright notes going up (E6 -> A6), short and light
save("correct", seq(tone(1318.5, 0.11, decay=0.06), tone(1760.0, 0.28, decay=0.09)))
# wrong: two soft low notes going down (A3 -> F3), not harsh
save("wrong", seq(tone(220.0, 0.14, "tri", decay=0.08), tone(174.6, 0.30, "tri", decay=0.12), gap=0.02), peak_db=-6)
# speak start / end: one short blip up / down
save("speak_start", glide(660, 990, 0.12))
save("speak_end", glide(990, 660, 0.12))
print("ok")
