import 'dart:math';
import 'package:flutter/material.dart';

/// 두 스페인어 문장의 유사도 계산.
///
/// 단어 매칭 70% + Levenshtein 거리 30% 가중 평균.
/// (참고 프로젝트 speak_english/lib/utils/text_similarity.dart 포팅)
class TextSimilarity {
  TextSimilarity._();

  static const double passThreshold = 0.8;

  static double calculate(String spoken, String target) {
    final s = _normalize(spoken);
    final t = _normalize(target);
    if (s == t) return 1.0;
    if (s.isEmpty || t.isEmpty) return 0.0;

    final spokenWords = s.split(' ').toSet();
    final targetWords = t.split(' ').toSet();
    final matches = spokenWords.intersection(targetWords).length;
    final wordAccuracy = matches / targetWords.length;

    final levenshtein =
        1.0 - (_levenshtein(s, t) / max(t.length, 1) * 1.5);
    final result = wordAccuracy * 0.7 + levenshtein.clamp(0.0, 1.0) * 0.3;
    return result.clamp(0.0, 1.0);
  }

  static bool isPass(double accuracy) => accuracy >= passThreshold;

  static String toPercent(double accuracy) =>
      '${(accuracy * 100).round()}%';

  static Color colorOf(double accuracy) {
    if (accuracy >= 0.8) return Colors.green;
    if (accuracy >= 0.6) return Colors.orange;
    return Colors.red;
  }

  static String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('¿', '')
        .replaceAll('¡', '')
        .replaceAll(RegExp(r'[^\wáéíóúüñ\s]', unicode: true), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  static int _levenshtein(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;
    List<int> v0 = List<int>.generate(s2.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(s2.length + 1, 0);
    for (int i = 0; i < s1.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < s2.length; j++) {
        final cost = s1[i] == s2[j] ? 0 : 1;
        v1[j + 1] = [v1[j] + 1, v0[j + 1] + 1, v0[j] + cost]
            .reduce((a, b) => a < b ? a : b);
      }
      final tmp = v0;
      v0 = v1;
      v1 = tmp;
    }
    return v0[s2.length];
  }
}
