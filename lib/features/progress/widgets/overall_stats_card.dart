import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class OverallStatsCard extends StatelessWidget {
  final Map<String, dynamic> summary;
  const OverallStatsCard({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalQuestions = summary['totalQuestions'] as int? ?? 0;
    final averageAccuracy = summary['averageAccuracy'] as double? ?? 0.0;
    final totalDays = summary['totalDays'] as int? ?? 0;
    final totalStudyTime = summary['totalStudyTime'] as int? ?? 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    '$totalQuestions',
                    l10n.totalStudied,
                    Icons.quiz_outlined,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    '${(averageAccuracy * 100).toStringAsFixed(0)}%',
                    l10n.accuracyRate,
                    Icons.percent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    l10n.daysUnit(totalDays),
                    l10n.studyDays,
                    Icons.calendar_today_outlined,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    l10n.minutes(totalStudyTime ~/ 60),
                    l10n.studyTime,
                    Icons.timer_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(height: 6),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }
}
