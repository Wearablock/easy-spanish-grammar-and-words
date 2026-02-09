import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.progress),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 전체 마스터리
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      l10n.overallProgress,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: 0.0,
                            strokeWidth: 10,
                            backgroundColor: theme.colorScheme.outline
                                .withValues(alpha: 0.15),
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        Text(
                          '0%',
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '0 / 1,120',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 레벨별 진행률
            Text(
              l10n.levelProgress,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 12),

            _buildLevelTile(
                context, 'A1', l10n.levelNameA1, AppColors.levelA1, 0.0),
            _buildLevelTile(
                context, 'A2', l10n.levelNameA2, AppColors.levelA2, 0.0),
            _buildLevelTile(
                context, 'B1', l10n.levelNameB1, AppColors.levelB1, 0.0),
            _buildLevelTile(
                context, 'B2', l10n.levelNameB2, AppColors.levelB2, 0.0),
            _buildLevelTile(
                context, 'C1', l10n.levelNameC1, AppColors.levelC1, 0.0),
            _buildLevelTile(
                context, 'C2', l10n.levelNameC2, AppColors.levelC2, 0.0),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelTile(
    BuildContext context,
    String level,
    String subtitle,
    Color color,
    double progress,
  ) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  level,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$level - $subtitle',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      color: color,
                      backgroundColor: color.withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(progress * 100).toInt()}%',
              style: theme.textTheme.labelLarge?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
