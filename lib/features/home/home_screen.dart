import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 목표 레벨 배지
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.levelB1.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.levelB1, width: 1),
              ),
              child: Text(
                'B1 ${l10n.levelTarget}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.levelB1,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 오늘의 학습 카드
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_stories,
                            color: theme.colorScheme.primary),
                        const SizedBox(width: 10),
                        Text(l10n.todayStudy,
                            style: theme.textTheme.titleSmall),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: const LinearProgressIndicator(
                        value: 0.0,
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.topicsProgress(0, 2),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 학습 시작 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: 학습 시작
                },
                icon: const Icon(Icons.play_arrow),
                label: Text(l10n.startStudy),
              ),
            ),
            const SizedBox(height: 24),

            // 전체 진행률 카드
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bar_chart,
                            color: theme.colorScheme.primary),
                        const SizedBox(width: 10),
                        Text(l10n.overallProgress,
                            style: theme.textTheme.titleSmall),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 문법 진행률
                    _buildProgressRow(
                      context,
                      label: l10n.grammar,
                      color: AppColors.grammar,
                      progress: 0.0,
                    ),
                    const SizedBox(height: 12),

                    // 어휘 진행률
                    _buildProgressRow(
                      context,
                      label: l10n.vocabulary,
                      color: AppColors.vocabulary,
                      progress: 0.0,
                    ),
                    const SizedBox(height: 12),

                    Text(
                      l10n.questionsMastered(0, 1120),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRow(
    BuildContext context, {
    required String label,
    required Color color,
    required double progress,
  }) {
    final theme = Theme.of(context);

    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(label, style: theme.textTheme.bodySmall),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              color: color,
              backgroundColor: color.withValues(alpha: 0.15),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${(progress * 100).toInt()}%',
          style: theme.textTheme.labelMedium,
        ),
      ],
    );
  }
}
