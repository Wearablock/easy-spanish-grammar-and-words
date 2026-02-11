import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/question.dart';
import '../../../data/providers/premium_provider.dart';
import '../../../data/providers/tts_providers.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/ad_service.dart';
import 'question_header.dart';
import 'option_button.dart';
import 'explanation_card.dart';
import 'tts_button.dart';

class QuizCard extends ConsumerStatefulWidget {
  final Question question;
  final VoidCallback onNext;
  final void Function(bool isCorrect, String? selectedAnswer) onAnswered;

  const QuizCard({
    super.key,
    required this.question,
    required this.onNext,
    required this.onAnswered,
  });

  @override
  ConsumerState<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends ConsumerState<QuizCard> {
  late List<String> _shuffledOptions;
  int? _selectedIndex;
  bool _answered = false;
  bool _showHint = false;
  bool _isLoadingAd = false;

  @override
  void initState() {
    super.initState();
    _shuffledOptions = widget.question.getShuffledOptions();
  }

  int get _correctIndex =>
      widget.question.getCorrectIndex(_shuffledOptions);

  /// 선택지가 스페인어인지 (한국어 선택지에는 TTS 숨김)
  bool get _areOptionsSpanish {
    final q = widget.question;
    if (q.type == QuestionType.translation &&
        q.translationDir == TranslationDirection.esToKo) {
      return false; // 선택지가 한국어
    }
    if (q.type == QuestionType.meaning || q.type == QuestionType.context) {
      return false; // 선택지가 한국어 뜻
    }
    return true;
  }

  /// 괄호 힌트 제거 — "Yo ___ estudiante. (ser 동사 활용)" → "Yo ___ estudiante."
  static final _trailingParen = RegExp(r'\s*\([^)]*\)\s*$');
  String _stripHint(String text) => text.replaceAll(_trailingParen, '').trim();

  /// 정답 확인 후 문제 텍스트의 TTS 재생용 스페인어 텍스트
  String? get _questionTtsText {
    final q = widget.question;
    switch (q.type) {
      case QuestionType.fillBlank:
      case QuestionType.conjugation:
        return _stripHint(q.question).replaceAll('___', q.correct);
      case QuestionType.translation:
        if (q.translationDir == TranslationDirection.esToKo) {
          return q.question; // 문제가 스페인어
        }
        return null; // koToEs: 문제가 한국어
      case QuestionType.listening:
      case QuestionType.sentenceOrder:
        return q.question;
      case QuestionType.meaning:
      case QuestionType.context:
        return null; // 문제가 한국어
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 퀴즈 헤더 아이콘
          Row(
            children: [
              Icon(Icons.quiz, color: theme.colorScheme.secondary, size: 20),
              const SizedBox(width: 8),
              Text(
                'Quiz',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 문제 텍스트
          QuestionHeader(
            questionText: widget.question.question,
            questionContext: widget.question.context,
          ),

          // 정답 확인 후 문제 텍스트 TTS (문장형 스페인어)
          if (_answered && _questionTtsText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: TtsButton(text: _questionTtsText!, iconSize: 20),
            ),
          const SizedBox(height: 8),

          // 힌트 버튼
          if (widget.question.hasHint && !_showHint && !_answered)
            _isLoadingAd
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : TextButton.icon(
                    onPressed: _onHintTap,
                    icon: const Icon(Icons.lightbulb_outline, size: 18),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.showHint),
                        if (!ref.watch(isPremiumProvider)) ...[
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondary
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'AD',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

          // 힌트 표시
          if (_showHint && widget.question.hint != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb,
                      color: theme.colorScheme.secondary, size: 16),
                  const SizedBox(width: 8),
                  Expanded(child: Text(widget.question.hint!)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),

          // 선택지
          ...List.generate(_shuffledOptions.length, (index) {
            return Row(
              children: [
                Expanded(
                  child: OptionButton(
                    index: index,
                    text: _shuffledOptions[index],
                    optionState: _getOptionState(index),
                    onTap: () => _onOptionSelected(index),
                  ),
                ),
                if (_answered && _areOptionsSpanish)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 12),
                    child: TtsButton(
                      text: _shuffledOptions[index],
                      iconSize: 18,
                    ),
                  ),
              ],
            );
          }),

          // 해설 (정답 확인 후)
          if (_answered) ...[
            const SizedBox(height: 16),
            ExplanationCard(explanation: widget.question.explanation),
            const SizedBox(height: 24),

            // 다음 문제 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onNext,
                child: Text(l10n.nextQuestion),
              ),
            ),
          ],

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  OptionState _getOptionState(int index) {
    if (!_answered) {
      return OptionState.normal;
    }
    if (index == _correctIndex) {
      return OptionState.correct;
    }
    if (index == _selectedIndex) {
      return OptionState.wrong;
    }
    return OptionState.disabled;
  }

  void _onOptionSelected(int index) {
    if (_answered) return;

    setState(() {
      _selectedIndex = index;
      _answered = true;
    });

    final isCorrect = index == _correctIndex;
    final selectedAnswer = _shuffledOptions[index];
    widget.onAnswered(isCorrect, selectedAnswer);

    if (isCorrect) {
      _autoPlayTts();
    }
  }

  Future<void> _onHintTap() async {
    final isPremium = ref.read(isPremiumProvider);
    final adService = AdService();

    if (isPremium) {
      // 프리미엄: 광고 없이 힌트 표시
      setState(() => _showHint = true);
      return;
    }

    if (adService.isRewardedAdReady) {
      await adService.showRewardedAd(
        onRewarded: (reward) {
          if (mounted) setState(() => _showHint = true);
        },
      );
    } else {
      // 광고 미준비: 즉석 로드 시도
      setState(() => _isLoadingAd = true);
      final loaded = await adService.tryLoadRewardedAd();
      if (!mounted) return;

      if (loaded) {
        await adService.showRewardedAd(
          onRewarded: (reward) {
            if (mounted) setState(() => _showHint = true);
          },
        );
      } else {
        // 폴백: 광고 없이 힌트 표시
        setState(() => _showHint = true);
      }
      if (mounted) setState(() => _isLoadingAd = false);
    }
  }

  Future<void> _autoPlayTts() async {
    final autoPlay = await ref.read(ttsAutoPlayProvider.future);
    if (!autoPlay) return;

    final q = widget.question;
    final String textToSpeak;

    switch (q.type) {
      case QuestionType.fillBlank:
      case QuestionType.conjugation:
        textToSpeak = _stripHint(q.question).replaceAll('___', q.correct);
      case QuestionType.translation:
        if (q.translationDir == TranslationDirection.esToKo) {
          textToSpeak = q.question;
        } else {
          textToSpeak = q.correct;
        }
      case QuestionType.listening:
      case QuestionType.sentenceOrder:
        textToSpeak = q.question;
      case QuestionType.meaning:
      case QuestionType.context:
        textToSpeak = q.correct;
    }

    ref.read(ttsServiceProvider).speak(textToSpeak);
  }
}
