import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../speaking_practice/screens/seed_list_screen.dart';

/// 홈 화면 — 말하기 연습/테스트 진입 카드.
///
/// 학습 카드와 시각적으로 구별되도록 스페인 골드 그라데이션 배경 +
/// 마이크 워터마크 + NUEVO 배지 적용.
class SpeakingPracticeCta extends StatelessWidget {
  const SpeakingPracticeCta({super.key});

  static const Color _goldDeep = Color(0xFF6B4E00);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withValues(alpha: 0.22),
            AppColors.secondary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // 좌측 마이크 워터마크 (장식)
          Positioned(
            left: -8,
            top: -4,
            child: Icon(
              Icons.mic,
              size: 96,
              color: AppColors.secondary.withValues(alpha: 0.18),
            ),
          ),
          // NUEVO 배지 (우측 상단)
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'NUEVO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          // 본문
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.mic, color: _goldDeep, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      l10n.speakingPractice,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _goldDeep,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(right: 56),
                  child: Text(
                    l10n.speakingFeatureDesc,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _goldDeep.withValues(alpha: 0.78),
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            _open(context, isTestMode: false),
                        icon: const Icon(Icons.fitness_center, size: 18),
                        label: Text(l10n.practice),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _goldDeep,
                          side: BorderSide(
                            color: AppColors.secondary
                                .withValues(alpha: 0.7),
                            width: 1.2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () =>
                            _open(context, isTestMode: true),
                        icon: const Icon(Icons.quiz, size: 18),
                        label: Text(l10n.test),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: _goldDeep,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _open(BuildContext context, {required bool isTestMode}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpeakingSeedListScreen(isTestMode: isTestMode),
      ),
    );
  }
}
