import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/study_providers.dart';
import '../../../l10n/app_localizations.dart';

class WrongAnswerCard extends StatefulWidget {
  final WrongAnswerWithQuestion item;

  const WrongAnswerCard({super.key, required this.item});

  @override
  State<WrongAnswerCard> createState() => _WrongAnswerCardState();
}

class _WrongAnswerCardState extends State<WrongAnswerCard> {
  bool _expanded = false;

  String _extractCefrLevel(String levelId) {
    // levelId format: 'grammar_a1' or 'vocab_a2' → extract 'a1' or 'a2'
    final parts = levelId.split('_');
    return parts.length >= 2 ? parts.last : levelId;
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

              // Question text
              Text(
                questionText,
                style: theme.textTheme.bodyMedium,
                maxLines: _expanded ? null : 2,
                overflow: _expanded ? null : TextOverflow.ellipsis,
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
                              Text(
                                q.explanation,
                                style: theme.textTheme.bodySmall,
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
    Color valueColor,
  ) {
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
      ],
    );
  }
}
