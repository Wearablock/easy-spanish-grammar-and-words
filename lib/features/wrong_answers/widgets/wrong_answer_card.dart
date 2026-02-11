import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/question.dart';
import '../../../data/providers/study_providers.dart';
import '../../../l10n/app_localizations.dart';
import '../../study/widgets/tts_button.dart';

class WrongAnswerCard extends ConsumerStatefulWidget {
  final WrongAnswerWithQuestion item;

  const WrongAnswerCard({super.key, required this.item});

  @override
  ConsumerState<WrongAnswerCard> createState() => _WrongAnswerCardState();
}

class _WrongAnswerCardState extends ConsumerState<WrongAnswerCard> {
  bool _expanded = false;

  String _extractCefrLevel(String levelId) {
    // levelId format: 'grammar_a1' or 'vocab_a2' → extract 'a1' or 'a2'
    final parts = levelId.split('_');
    return parts.length >= 2 ? parts.last : levelId;
  }

  /// 문제 텍스트가 스페인어인지 (TTS 표시 여부)
  bool _isQuestionSpanish(Question q) {
    switch (q.type) {
      case QuestionType.fillBlank:
      case QuestionType.conjugation:
      case QuestionType.listening:
      case QuestionType.sentenceOrder:
        return true;
      case QuestionType.translation:
        return q.translationDir == TranslationDirection.esToKo;
      case QuestionType.meaning:
      case QuestionType.context:
        return false; // 문제가 한국어
    }
  }

  /// 정답이 스페인어인지 (TTS 표시 여부)
  bool _isCorrectSpanish(Question q) {
    switch (q.type) {
      case QuestionType.fillBlank:
      case QuestionType.conjugation:
      case QuestionType.listening:
      case QuestionType.sentenceOrder:
        return true;
      case QuestionType.translation:
        return q.translationDir == TranslationDirection.koToEs;
      case QuestionType.meaning:
      case QuestionType.context:
        return false; // 정답이 한국어 뜻
    }
  }

  /// 괄호 힌트 제거 (TTS용)
  static final _trailingParen = RegExp(r'\s*\([^)]*\)\s*$');
  String _questionTtsText(Question q) {
    final text = q.question.replaceAll(_trailingParen, '').trim();
    return text.replaceAll('___', q.correct);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final wa = widget.item.wrongAnswer;
    final q = widget.item.question;

    final cefrLevel = _extractCefrLevel(wa.levelId);
    final levelColor = AppColors.getLevelColor(cefrLevel);
    final questionText = q?.question ?? wa.questionId;
    final hasBlank = questionText.contains('___');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: levelColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      cefrLevel.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: levelColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.wrongCount(wa.wrongCount),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.wrong,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: theme.colorScheme.outline,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Question text + TTS (스페인어인 경우만)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      questionText,
                      style: theme.textTheme.bodyMedium,
                      maxLines: _expanded ? null : 2,
                      overflow: _expanded ? null : TextOverflow.ellipsis,
                    ),
                  ),
                  if (q != null && _isQuestionSpanish(q)) ...[
                    const SizedBox(width: 4),
                    TtsButton(
                      text: hasBlank ? _questionTtsText(q) : questionText,
                      iconSize: 18,
                    ),
                  ],
                ],
              ),

              // Expanded details
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: q != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              context,
                              l10n.correctAnswer,
                              q.correct,
                              AppColors.correct,
                              showTts: _isCorrectSpanish(q),
                            ),
                            if (wa.lastWrongAnswer != null) ...[
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                context,
                                l10n.yourAnswer,
                                wa.lastWrongAnswer!,
                                AppColors.wrong,
                              ),
                            ],
                            if (q.explanation.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                l10n.explanation,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              MarkdownBody(
                                data: q.explanation,
                                styleSheet:
                                    MarkdownStyleSheet.fromTheme(theme)
                                        .copyWith(
                                  p: theme.textTheme.bodySmall,
                                ),
                                shrinkWrap: true,
                                softLineBreak: true,
                              ),
                            ],
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                crossFadeState: _expanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    Color valueColor, {
    bool showTts = false,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (showTts) ...[
          const SizedBox(width: 4),
          TtsButton(text: value, iconSize: 16),
        ],
      ],
    );
  }
}
