import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';

/// 홈 화면 — 말하기 복습 대기 카드 알림.
///
/// 학습 복습 알림(`ReviewAlertCard`)과 시각적으로 구분되도록
/// Spanish Gold 톤 사용.
class SpeakingReviewAlertCard extends StatelessWidget {
  final int count;
  final VoidCallback onTap;

  const SpeakingReviewAlertCard({
    super.key,
    required this.count,
    required this.onTap,
  });

  static const Color _goldDeep = Color(0xFF6B4E00);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.secondary.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withValues(alpha: 0.3),
                ),
                child: const Icon(
                  Icons.mic,
                  color: _goldDeep,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.speakingReview,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _goldDeep,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.speakingReviewDue(count),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _goldDeep.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: _goldDeep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
