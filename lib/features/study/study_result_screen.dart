import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/study_session.dart';
import '../../data/providers/premium_provider.dart';
import '../../data/providers/study_providers.dart';
import '../../l10n/app_localizations.dart';
import '../../services/ad_service.dart';
import 'controllers/study_session_controller.dart';
import 'study_session_screen.dart';

class StudyResultScreen extends ConsumerStatefulWidget {
  final StudySession session;
  final bool isReviewSession;

  const StudyResultScreen({
    super.key,
    required this.session,
    this.isReviewSession = false,
  });

  @override
  ConsumerState<StudyResultScreen> createState() => _StudyResultScreenState();
}

class _StudyResultScreenState extends ConsumerState<StudyResultScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(appStatsProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final session = widget.session;

    final accuracyPercent = (session.accuracy * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.studyComplete),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 16),

            // 완료 아이콘
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 24),

            // 축하 메시지
            Text(
              _getCompletionMessage(session.accuracy, l10n),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.goodJob,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 32),

            // 결과 카드
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // 정답률
                    Text(
                      '$accuracyPercent%',
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getAccuracyColor(session.accuracy),
                      ),
                    ),
                    Text(
                      l10n.accuracy,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),

                    // 정답/오답/시간
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem(
                          context,
                          label: l10n.correct,
                          value: '${session.correctCount}',
                          color: AppColors.correct,
                        ),
                        _buildStatItem(
                          context,
                          label: l10n.wrong,
                          value: '${session.wrongCount}',
                          color: AppColors.wrong,
                        ),
                        _buildStatItem(
                          context,
                          label: l10n.timeSpent,
                          value: session.durationFormatted,
                          color: theme.colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 단계별 결과
            if (_hasPhaseResults()) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.phaseResults,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (session.wrongReviewQuizCount > 0)
                        _buildPhaseRow(
                          context,
                          label: l10n.wrongReview,
                          completed: session.wrongReviewCompletedCount,
                          total: session.wrongReviewQuizCount,
                        ),
                      if (session.spacedReviewQuizCount > 0)
                        _buildPhaseRow(
                          context,
                          label: l10n.spacedReview,
                          completed: session.spacedReviewCompletedCount,
                          total: session.spacedReviewQuizCount,
                        ),
                      if (session.newLearningQuizCount > 0)
                        _buildPhaseRow(
                          context,
                          label: l10n.newLearning,
                          completed: session.newLearningCompletedCount,
                          total: session.newLearningQuizCount,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            const SizedBox(height: 8),

            // 액션 버튼
            _buildActionButtons(context, l10n),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _getCompletionMessage(double accuracy, AppLocalizations l10n) {
    if (accuracy >= 0.9) return l10n.excellentComplete;
    if (accuracy >= 0.7) return l10n.goodComplete;
    return l10n.studyComplete;
  }

  Color _getAccuracyColor(double accuracy) {
    if (accuracy >= 0.9) return AppColors.correct;
    if (accuracy >= 0.7) return AppColors.warning;
    return AppColors.wrong;
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }

  bool _hasPhaseResults() {
    final session = widget.session;
    return session.wrongReviewQuizCount > 0 ||
        session.spacedReviewQuizCount > 0 ||
        session.newLearningQuizCount > 0;
  }

  Widget _buildPhaseRow(
    BuildContext context, {
    required String label,
    required int completed,
    required int total,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(
            '$completed / $total',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, AppLocalizations l10n) {
    final todaySummaryAsync = ref.watch(todaySummaryProvider);

    return todaySummaryAsync.when(
      loading: () => _buildDefaultButtons(context, l10n),
      error: (_, _) => _buildDefaultButtons(context, l10n),
      data: (summary) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.isReviewSession && summary.reviewDueCount > 0)
              ElevatedButton(
                onPressed: () => _startNewSession(isReview: true),
                child: Text(
                    l10n.continueReviewWithCount(summary.reviewDueCount)),
              ),
            if (!summary.allTopicsCompleted)
              ElevatedButton(
                onPressed: () => _startNewSession(isReview: false),
                child: Text(l10n.additionalStudy),
              ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _goHome,
              child: Text(l10n.goHome),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDefaultButtons(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
          onPressed: _goHome,
          child: Text(l10n.goHome),
        ),
      ],
    );
  }

  void _startNewSession({required bool isReview}) async {
    // 추가 학습/복습 시작 전 전면 광고
    final isPremium = ref.read(isPremiumProvider);
    if (!isPremium) {
      await AdService().showInterstitialAd();
    }

    ref.invalidate(studySessionControllerProvider);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => StudySessionScreen(isReviewOnly: isReview),
      ),
    );
  }

  void _goHome() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
