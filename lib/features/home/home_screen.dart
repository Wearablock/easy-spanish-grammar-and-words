import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/study_providers.dart';
import '../../l10n/app_localizations.dart';
import '../../services/study_service.dart';
import '../study/study_session_screen.dart';
import 'widgets/review_alert_card.dart';
import 'widgets/today_study_card.dart';
import 'widgets/study_cta_button.dart';
import 'widgets/overall_progress_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final todaySummaryAsync = ref.watch(todaySummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
      ),
      body: todaySummaryAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(l10n.error(error.toString()))),
        data: (summary) => _buildContent(context, ref, summary),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, TodaySummary summary) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(appStatsProvider);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 복습 알림 (있을 때만)
            if (summary.reviewDueCount > 0) ...[
              ReviewAlertCard(
                count: summary.reviewDueCount,
                onTap: () => _startReviewSession(context),
              ),
              const SizedBox(height: 16),
            ],

            TodayStudyCard(summary: summary),
            const SizedBox(height: 16),

            StudyCtaButton(
              summary: summary,
              onPressed: () => _startStudySession(context),
            ),
            const SizedBox(height: 24),

            OverallProgressCard(summary: summary),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _startStudySession(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const StudySessionScreen()),
    );
  }

  void _startReviewSession(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const StudySessionScreen(isReviewOnly: true),
      ),
    );
  }
}
