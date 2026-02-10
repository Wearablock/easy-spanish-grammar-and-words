import 'package:flutter/material.dart';
import '../../../core/config/constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/study_service.dart';

class LevelProgressList extends StatelessWidget {
  final Map<String, LevelProgress> levelProgress;

  const LevelProgressList({super.key, required this.levelProgress});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final levelNames = {
      'a1': l10n.levelNameA1,
      'a2': l10n.levelNameA2,
      'b1': l10n.levelNameB1,
      'b2': l10n.levelNameB2,
      'c1': l10n.levelNameC1,
      'c2': l10n.levelNameC2,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.levelProgress, style: theme.textTheme.titleSmall),
        const SizedBox(height: 12),
        ...LevelConstants.levels.map((level) {
          final progress = levelProgress[level] ??
              levelProgress['grammar_$level'] ??
              levelProgress['vocab_$level'];
          // Combine grammar + vocab for this CEFR level
          final gramProgress = levelProgress['grammar_$level'];
          final vocabProgress = levelProgress['vocab_$level'];

          int totalQ = 0;
          int studiedQ = 0;
          int masteredQ = 0;

          if (gramProgress != null) {
            totalQ += gramProgress.totalQuestions;
            studiedQ += gramProgress.studiedQuestions;
            masteredQ += gramProgress.masteredQuestions;
          }
          if (vocabProgress != null) {
            totalQ += vocabProgress.totalQuestions;
            studiedQ += vocabProgress.studiedQuestions;
            masteredQ += vocabProgress.masteredQuestions;
          }
          // Also check plain level key (e.g., 'a1')
          if (progress != null &&
              gramProgress == null &&
              vocabProgress == null) {
            totalQ = progress.totalQuestions;
            studiedQ = progress.studiedQuestions;
            masteredQ = progress.masteredQuestions;
          }

          final studiedProg = totalQ > 0 ? studiedQ / totalQ : 0.0;
          final masteredProg = totalQ > 0 ? masteredQ / totalQ : 0.0;
          final color = AppColors.getLevelColor(level);
          final levelLabel = level.toUpperCase();
          final subtitle = levelNames[level] ?? '';

          return _buildLevelTile(
            context,
            levelLabel,
            subtitle,
            color,
            studiedProg,
            masteredProg,
            totalQ,
            studiedQ,
            masteredQ,
          );
        }),
      ],
    );
  }

  Widget _buildLevelTile(
    BuildContext context,
    String level,
    String subtitle,
    Color color,
    double studiedProgress,
    double masteredProgress,
    int totalQuestions,
    int studiedQuestions,
    int masteredQuestions,
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
                    child: Stack(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: studiedProgress.clamp(0.0, 1.0),
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: masteredProgress.clamp(0.0, 1.0),
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$studiedQuestions / $totalQuestions',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(masteredProgress * 100).toInt()}%',
              style: theme.textTheme.labelLarge?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
