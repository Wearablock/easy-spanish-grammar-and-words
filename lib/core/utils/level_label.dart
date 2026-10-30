/// Levels show as LV1–LV6 on screen — no DELE, no A1–C2 (10-30: one scale for every language app).
/// Data and settings keep the CEFR ids (a1 … c2); only what the learner sees changes.
const _cefrOrder = ['a1', 'a2', 'b1', 'b2', 'c1', 'c2'];

String levelLabel(String cefr) {
  final i = _cefrOrder.indexOf(cefr.toLowerCase());
  return i < 0 ? cefr.toUpperCase() : 'LV${i + 1}';
}
