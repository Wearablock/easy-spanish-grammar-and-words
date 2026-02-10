import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/study_service.dart';

class TodayStudyCard extends StatelessWidget {
  final TodaySummary summary;

  const TodayStudyCard({super.key, required this.summary});

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
                Icon(Icons.auto_stories, color: theme.colorScheme.primary),
                const SizedBox(width: 10),
                Text(l10n.todayStudy, style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 16),

            // 다음 토픽 정보
            if (summary.allTopicsCompleted) ...[
              Text(
                l10n.allTopicsCompleted,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.reviewEncouragement,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ] else if (summary.hasNextTopic) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.nextTopic,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  Text(
                    l10n.questionsCount(summary.nextTopicQuestionCount),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),

            // 일일 목표 진행률
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: summary.todayProgress,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.topicsProgress(
                    summary.todayStudiedTopics,
                    summary.dailyGoalTopics,
                  ),
                  style: theme.textTheme.bodySmall,
                ),
                if (summary.streak > 0)
                  Text(
                    l10n.streakDays(summary.streak),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),

            // 오늘 학습한 문제 수
            if (summary.questionsStudied > 0) ...[
              const SizedBox(height: 8),
              Text(
                l10n.todayQuestionsCompleted(summary.questionsStudied),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
