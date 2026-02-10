import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/study_providers.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/level_progress_list.dart';
import 'widgets/overall_stats_card.dart';
import 'widgets/streak_card.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final overallProgressAsync = ref.watch(overallProgressProvider);
    final overallSummaryAsync = ref.watch(overallSummaryProvider);
    final levelProgressAsync = ref.watch(levelProgressProvider);
    final todaySummaryAsync = ref.watch(todaySummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.progress),
      ),
      body: overallSummaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.error(e.toString()))),
        data: (summary) {
          final overallProgress = overallProgressAsync.value ?? 0.0;
          final levelProgress = levelProgressAsync.value ?? {};
          final todaySummary = todaySummaryAsync.value;
          final totalQuestions = todaySummary?.totalQuestions ??
              summary['totalQuestions'] as int? ??
              0;
          final masteredCount = todaySummary?.masteredCount ?? 0;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overall mastery
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color:
                        theme.colorScheme.primary.withValues(alpha: 0.05),
                    border: Border(
                      bottom: BorderSide(
                        color: theme.colorScheme.outline
                            .withValues(alpha: 0.12),
                      ),
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final indicatorSize =
                          (constraints.maxWidth * 0.35).clamp(100.0, 160.0);
                      final strokeWidth = indicatorSize * 0.08;

                      return Column(
                        children: [
                          Text(l10n.overallProgress,
                              style: theme.textTheme.titleSmall),
                          const SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: indicatorSize,
                                height: indicatorSize,
                                child: CircularProgressIndicator(
                                  value: overallProgress.clamp(0.0, 1.0),
                                  strokeWidth: strokeWidth,
                                  backgroundColor: theme.colorScheme.outline
                                      .withValues(alpha: 0.15),
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              Text(
                                '${(overallProgress * 100).toInt()}%',
                                style:
                                    theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            l10n.questionsMastered(
                                masteredCount, totalQuestions),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Stats card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: OverallStatsCard(summary: summary),
                ),
                const SizedBox(height: 12),

                // Streak card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StreakCard(
                    currentStreak:
                        summary['currentStreak'] as int? ?? 0,
                    longestStreak:
                        summary['longestStreak'] as int? ?? 0,
                  ),
                ),
                const SizedBox(height: 24),

                // Level progress list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child:
                      LevelProgressList(levelProgress: levelProgress),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
