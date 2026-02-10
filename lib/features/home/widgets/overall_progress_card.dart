import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/study_service.dart';

class OverallProgressCard extends StatelessWidget {
  final TodaySummary summary;

  const OverallProgressCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bar_chart, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Text(l10n.overallProgress, style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 16),

            // 이중 프로그레스 바
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: [
                  // 배경
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outline.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // 1회 이상 학습 (연한 색)
                  FractionallySizedBox(
                    widthFactor: summary.studiedProgress.clamp(0.0, 1.0),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  // 완전 습득 (진한 색)
                  FractionallySizedBox(
                    widthFactor: summary.overallProgress.clamp(0.0, 1.0),
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.correct,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 범례
            Row(
              children: [
                _buildLegendDot(AppColors.correct),
                const SizedBox(width: 4),
                Text(l10n.mastered, style: theme.textTheme.bodySmall),
                const SizedBox(width: 16),
                _buildLegendDot(
                    theme.colorScheme.primary.withValues(alpha: 0.3)),
                const SizedBox(width: 4),
                Text(l10n.studiedOnce, style: theme.textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 8),

            Text(
              l10n.questionsMastered(summary.masteredCount, summary.totalQuestions),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendDot(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
