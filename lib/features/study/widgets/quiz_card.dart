import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/question.dart';
import '../../../data/providers/tts_providers.dart';
import '../../../l10n/app_localizations.dart';
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

  @override
  void initState() {
    super.initState();
    _shuffledOptions = widget.question.getShuffledOptions();
  }

  int get _correctIndex =>
      widget.question.getCorrectIndex(_shuffledOptions);

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
          const SizedBox(height: 8),

          // 힌트 버튼
          if (widget.question.hasHint && !_showHint && !_answered)
            TextButton.icon(
              onPressed: () => setState(() => _showHint = true),
              icon: const Icon(Icons.lightbulb_outline, size: 18),
              label: Text(l10n.showHint),
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
                if (_answered)
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

  Future<void> _autoPlayTts() async {
    final autoPlay = await ref.read(ttsAutoPlayProvider.future);
    if (!autoPlay) return;

    final q = widget.question;
    final String textToSpeak;

    switch (q.type) {
      case QuestionType.fillBlank:
      case QuestionType.conjugation:
        textToSpeak = q.question.replaceAll('___', q.correct);
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
