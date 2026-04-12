import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

/// 말하기 기능 전용 디자인 팔레트.
///
/// 회색 베이스를 지양하고 스페인 브랜드 컬러(레드/골드)와
/// 정확도 시각화(정답률에 따른 그라디언트)를 일관된 시스템으로 제공한다.
class SpeakingPalette {
  SpeakingPalette._();

  // ── 정확도 컬러 ────────────────────────────────────────

  /// 정확도(0.0~1.0)에 해당하는 강조 컬러.
  /// 통과(≥0.8) 그린 / 보통(0.6~0.8) 골드 / 미달 레드
  static Color accuracyAccent(double accuracy) {
    if (accuracy >= 0.8) return AppColors.correct; // #4CAF50
    if (accuracy >= 0.6) return AppColors.secondary; // Spanish Gold #FFC400
    return AppColors.primary; // Spanish Red #C60B1E
  }

  /// 정확도 카드 배경 — 강조 컬러 → 따뜻한 surface 톤으로 그라디언트.
  /// 회색 단색 대신 입체감 있는 부드러운 배경을 만든다.
  static BoxDecoration accuracyDecoration(double accuracy) {
    final accent = accuracyAccent(accuracy);
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          accent.withValues(alpha: 0.18),
          accent.withValues(alpha: 0.06),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: accent.withValues(alpha: 0.25),
        width: 1,
      ),
    );
  }

  /// 정확도 텍스트 색 (헤드라인 % 표시용).
  static Color accuracyText(double accuracy) => accuracyAccent(accuracy);

  // ── 시드 목록 칩 컬러 ──────────────────────────────────

  /// CEFR 레벨 칩 — 레벨별 컬러 + 옅은 배경.
  static BoxDecoration levelChipDecoration(String level) {
    final color = AppColors.getLevelColor(level.toLowerCase());
    return BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 0.8),
    );
  }

  static Color levelChipText(String level) =>
      AppColors.getLevelColor(level.toLowerCase());

  /// 동사 칩 — Spanish Gold 톤.
  static BoxDecoration verbChipDecoration() => BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: AppColors.secondary.withValues(alpha: 0.4), width: 0.8),
      );

  static Color get verbChipText => const Color(0xFF8B6914); // 진한 골드

  /// 카드 수 칩 — Spanish Red 톤.
  static BoxDecoration countChipDecoration() => BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: AppColors.primary.withValues(alpha: 0.25), width: 0.8),
      );

  static Color get countChipText => AppColors.primary;

  // ── 텍스트 스타일 ──────────────────────────────────────

  /// 보조 라벨/힌트 텍스트 — 회색 대신 onSurfaceVariant 사용.
  static TextStyle hintLabel(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 12,
      color: cs.onSurfaceVariant,
      fontWeight: FontWeight.w500,
    );
  }

  /// 카드 의미(번역) 텍스트 — 살짝 흐린 onSurface.
  static TextStyle meaningText(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
      fontStyle: FontStyle.italic,
    );
  }

  // ── 변형 라벨 배지 ─────────────────────────────────────

  /// 연습/테스트 카드의 변형 종류 배지 — 브랜드 골드 톤.
  static BoxDecoration variationBadgeDecoration() => BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.5),
          width: 0.8,
        ),
      );

  /// 변형 배지 텍스트 — 진한 골드 (대비비 ≥4.5).
  static TextStyle variationBadgeText(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.copyWith(
            color: const Color(0xFF6B4E00),
            fontWeight: FontWeight.w700,
          );

  // ── 마이크 버튼 비활성 ─────────────────────────────────

  /// 답변 후 비활성 마이크 — 회색 대신 outline 컬러.
  static Color disabledMicColor(BuildContext context) =>
      Theme.of(context).colorScheme.outline;

  // ── 결과 화면 트로피/리프레시 아이콘 ───────────────────

  /// 테스트 합격/불합격 아이콘 컬러.
  static Color resultIcon(bool isPass) =>
      isPass ? AppColors.secondary : AppColors.primary; // 골드 / 레드
}
