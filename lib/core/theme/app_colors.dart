import 'package:flutter/material.dart';

/// 앱 색상 정의 (스페인 모티프)
///
/// Brand Colors만 앱별로 교체하면 전체 테마가 자동 반영된다.
class AppColors {
  AppColors._();

  // ============================================================
  // Brand Colors — 앱별 교체 대상
  // ============================================================

  static const Color primary = Color(0xFFC60B1E); // Spanish Red
  static const Color primaryLight = Color(0xFFE8384F); // Dark mode primary
  static const Color secondary = Color(0xFFFFC400); // Spanish Gold
  static const Color secondaryLight = Color(0xFFFFD54F); // Dark mode secondary
  static const Color negative = Color(0xFFE53935); // Error / Wrong
  static const Color surfaceLight = Color(0xFFFFFBF5); // Light surface (warm)
  static const Color surfaceDark = Color(0xFF1A1A1A); // Dark surface

  // ============================================================
  // Semantic Colors
  // ============================================================

  static const Color correct = Color(0xFF4CAF50);
  static const Color wrong = Color(0xFFF44336);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);

  // ============================================================
  // CEFR Level Colors
  // ============================================================

  static const Color levelA1 = Color(0xFF4CAF50);
  static const Color levelA2 = Color(0xFF8BC34A);
  static const Color levelB1 = Color(0xFFFF9800);
  static const Color levelB2 = Color(0xFFFF5722);
  static const Color levelC1 = Color(0xFFE91E63);
  static const Color levelC2 = Color(0xFF9C27B0);

  // ============================================================
  // Category Colors
  // ============================================================

  static const Color grammar = Color(0xFF1565C0);
  static const Color vocabulary = Color(0xFFE65100);

  /// CEFR 레벨에 해당하는 색상 반환
  static Color getLevelColor(String level) {
    switch (level) {
      case 'a1':
        return levelA1;
      case 'a2':
        return levelA2;
      case 'b1':
        return levelB1;
      case 'b2':
        return levelB2;
      case 'c1':
        return levelC1;
      case 'c2':
        return levelC2;
      default:
        return const Color(0xFF9E9E9E);
    }
  }
}
