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
import '../speaking/speak_box.dart';
import '../speaking/speak_target.dart';

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

/// 10-29 리뉴얼 — 1.4.0 은 100% «읽고 고르기» 였다. 빈칸 문제의 일부를 듣기 · 쓰기로 돌려 한 판 안에서 영역을 섞는다
/// 새 문제를 만들지 않고 있는 1,880문제를 그대로 쓴다 · 어느 문제가 어떤 방식인지는 문제 id 로 정해져서 매번 같다
enum _QuizMode { choose, listen, type }

class _QuizCardState extends ConsumerState<QuizCard> {
  late List<String> _shuffledOptions;
  late final _QuizMode _mode;
  final _typed = TextEditingController();
  int? _selectedIndex;
  bool _answered = false;
  bool _showHint = false;
  bool _isLoadingAd = false;

  @override
  void initState() {
    super.initState();
    _shuffledOptions = widget.question.getShuffledOptions();
    _mode = _pickMode();
    if (_mode == _QuizMode.listen) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _speakSentence());
    }
  }

  @override
  void dispose() {
    _typed.dispose();
    super.dispose();
  }

  _QuizMode _pickMode() {
    final q = widget.question;
    final blank =
        (q.type == QuestionType.fillBlank ||
            q.type == QuestionType.conjugation) &&
        q.question.contains('___');
    if (!blank) return _QuizMode.choose;
    switch (q.id.codeUnits.fold<int>(0, (a, b) => a + b) % 3) {
      case 1:
        return _QuizMode.listen;
      case 2:
        // 한 낱말 정답만 쓰기로 — 여러 낱말을 치게 하면 폰에서 오타가 정답을 가린다
        return q.correct.trim().contains(' ')
            ? _QuizMode.choose
            : _QuizMode.type;
      default:
        return _QuizMode.choose;
    }
  }

  String get _fullSentence => _stripHint(
    widget.question.question,
  ).replaceAll('___', widget.question.correct);

  void _speakSentence() => ref.read(ttsServiceProvider).speak(_fullSentence);

  /// 대소문자 · 악센트 · 끝 문장부호는 봐준다(폰 키보드) — 정답 칸에는 바른 철자가 보인다
  static String _norm(String v) {
    const from = 'áéíóúüñ', to = 'aeiouun';
    var t = v.trim().toLowerCase().replaceAll(RegExp(r'[.!?¿¡,]'), '');
    for (var i = 0; i < from.length; i++) {
      t = t.replaceAll(from[i], to[i]);
    }
    return t;
  }

  void _onTypedSubmit() {
    if (_answered || _typed.text.trim().isEmpty) return;
    final isCorrect = _norm(_typed.text) == _norm(widget.question.correct);
    setState(() {
      _answered = true;
      _selectedIndex = isCorrect ? _correctIndex : -1;
    });
    widget.onAnswered(isCorrect, _typed.text.trim());
    final feedback = ref.read(feedbackServiceProvider);
    if (isCorrect) {
      feedback.playCorrect();
      _autoPlayTts();
    } else {
      feedback.playWrong();
    }
  }

  int get _correctIndex => widget.question.getCorrectIndex(_shuffledOptions);

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

          // 듣기 · 쓰기 안내
          if (_mode != _QuizMode.choose)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _mode == _QuizMode.listen
                    ? l10n.quizListenPrompt
                    : l10n.quizTypePrompt,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),

          // 문제 텍스트 — 듣기는 답하기 전까지 글을 숨기고 소리만 준다
          if (_mode == _QuizMode.listen && !_answered)
            Center(
              child: IconButton.filled(
                iconSize: 40,
                onPressed: _speakSentence,
                icon: const Icon(Icons.volume_up),
              ),
            )
          else
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
                              horizontal: 4,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondary.withValues(
                                alpha: 0.15,
                              ),
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
                  Icon(
                    Icons.lightbulb,
                    color: theme.colorScheme.secondary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(widget.question.hint!)),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),

          // 쓰기 — 빈칸 낱말을 직접 친다
          if (_mode == _QuizMode.type) ...[
            TextField(
              controller: _typed,
              enabled: !_answered,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _onTypedSubmit(),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: _answered
                    ? Icon(
                        _selectedIndex == _correctIndex
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: _selectedIndex == _correctIndex
                            ? Colors.green
                            : theme.colorScheme.error,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            if (!_answered)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onTypedSubmit,
                  child: Text(l10n.quizCheck),
                ),
              )
            else
              Text(
                widget.question.correct,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],

          // 선택지
          if (_mode != _QuizMode.type)
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
            // 1.6.0 — 답한 뒤 모든 문제에서 그 스페인어 문장을 듣고 말한다(speakTarget 이 고른다 · 정답 판정에는 안 섞음)
            if (speakTarget(widget.question) case final target?) ...[
              const SizedBox(height: 16),
              SpeakBox(
                key: ValueKey('speak-${widget.question.id}'),
                questionId: widget.question.id,
                target: target,
              ),
            ],
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

    // 효과음 + 진동
    final feedback = ref.read(feedbackServiceProvider);
    if (isCorrect) {
      feedback.playCorrect();
      _autoPlayTts();
    } else {
      feedback.playWrong();
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
