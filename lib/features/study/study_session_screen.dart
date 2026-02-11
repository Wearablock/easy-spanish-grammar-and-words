import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/study_session.dart';
import '../../data/providers/topic_providers.dart';
import '../../data/providers/tts_providers.dart';
import '../../l10n/app_localizations.dart';
import 'controllers/study_session_controller.dart';
import 'study_result_screen.dart';
import 'widgets/session_progress_bar.dart';
import 'widgets/theory_card.dart';
import 'widgets/quiz_card.dart';

class StudySessionScreen extends ConsumerStatefulWidget {
  final bool isReviewOnly;

  const StudySessionScreen({super.key, this.isReviewOnly = false});

  @override
  ConsumerState<StudySessionScreen> createState() =>
      _StudySessionScreenState();
}

class _StudySessionScreenState extends ConsumerState<StudySessionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(studySessionControllerProvider.notifier);
      if (widget.isReviewOnly) {
        controller.startReviewSession();
      } else {
        controller.startSession();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(studySessionControllerProvider);

    // 완료 시 TTS 중지 후 결과 화면으로 이동
    ref.listen(studySessionControllerProvider, (previous, next) {
      if (next.status == StudySessionStatus.completed &&
          previous?.status != StudySessionStatus.completed &&
          next.session != null) {
        ref.read(ttsServiceProvider).stop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StudyResultScreen(
              session: next.session!,
              isReviewSession: widget.isReviewOnly,
            ),
          ),
        );
      }
    });

    return PopScope(
      canPop: state.status != StudySessionStatus.inProgress,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop && state.status == StudySessionStatus.inProgress) {
          final shouldExit = await _showExitConfirmDialog(l10n);
          if (shouldExit == true && context.mounted) {
            ref.read(ttsServiceProvider).stop();
            ref.read(studySessionControllerProvider.notifier).cancelSession();
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_getLocalizedPhaseTitle(state.currentPhase, l10n)),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => _handleClose(state, l10n),
          ),
          actions: [
            if (state.status == StudySessionStatus.inProgress)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    '${state.currentIndex}/${state.totalItems}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
          ],
        ),
        body: _buildBody(state, l10n),
      ),
    );
  }

  Widget _buildBody(StudySessionState state, AppLocalizations l10n) {
    switch (state.status) {
      case StudySessionStatus.initial:
      case StudySessionStatus.loading:
        return const Center(child: CircularProgressIndicator());

      case StudySessionStatus.error:
        return _buildErrorView(state, l10n);

      case StudySessionStatus.completed:
        return const Center(child: CircularProgressIndicator());

      case StudySessionStatus.inProgress:
        return Column(
          children: [
            SessionProgressBar(progress: state.progress),
            const SizedBox(height: 8),
            Expanded(
              child: state.isTheory
                  ? _buildTheoryContent(state, l10n)
                  : _buildQuizContent(state),
            ),
          ],
        );
    }
  }

  Widget _buildErrorView(StudySessionState state, AppLocalizations l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.errorOccurred,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (state.errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                state.errorMessage!,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final controller =
                    ref.read(studySessionControllerProvider.notifier);
                if (widget.isReviewOnly) {
                  controller.startReviewSession();
                } else {
                  controller.startSession();
                }
              },
              child: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTheoryContent(StudySessionState state, AppLocalizations l10n) {
    final topicId = state.currentItem?.topicId;
    if (topicId == null) return const SizedBox.shrink();

    final topicAsync = ref.watch(topicByIdProvider(topicId));

    return topicAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(l10n.error(error.toString()))),
      data: (topic) {
        if (topic == null) return const SizedBox.shrink();
        return TheoryCard(
          topic: topic,
          onCompleted: () {
            ref.read(studySessionControllerProvider.notifier).completeTheory();
          },
        );
      },
    );
  }

  Widget _buildQuizContent(StudySessionState state) {
    final question = state.currentQuestion;
    if (question == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return QuizCard(
      key: ValueKey(question.id),
      question: question,
      onAnswered: (isCorrect, selectedAnswer) {
        final controller = ref.read(studySessionControllerProvider.notifier);
        if (isCorrect) {
          controller.answerCorrect();
        } else {
          controller.answerWrong(selectedAnswer ?? '');
        }
      },
      onNext: () {
        ref.read(studySessionControllerProvider.notifier).moveNext();
      },
    );
  }

  String _getLocalizedPhaseTitle(SessionPhase phase, AppLocalizations l10n) {
    switch (phase) {
      case SessionPhase.wrongReview:
        return l10n.wrongReview;
      case SessionPhase.spacedReview:
        return l10n.spacedReview;
      case SessionPhase.newLearning:
        return l10n.newLearning;
      case SessionPhase.completed:
        return l10n.studyComplete;
    }
  }

  void _handleClose(StudySessionState state, AppLocalizations l10n) async {
    if (state.status == StudySessionStatus.inProgress) {
      final shouldExit = await _showExitConfirmDialog(l10n);
      if (shouldExit == true && mounted) {
        ref.read(ttsServiceProvider).stop();
        ref.read(studySessionControllerProvider.notifier).cancelSession();
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
    }
  }

  Future<bool?> _showExitConfirmDialog(AppLocalizations l10n) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.stopStudy),
        content: Text(l10n.stopStudyConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.continueStudyButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.stop),
          ),
        ],
      ),
    );
  }
}
