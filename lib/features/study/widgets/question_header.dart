import 'package:flutter/material.dart';

class QuestionHeader extends StatelessWidget {
  final String questionText;
  final String? questionContext;

  const QuestionHeader({
    super.key,
    required this.questionText,
    this.questionContext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (questionContext != null && questionContext!.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.outline.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              questionContext!,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Text(
          questionText,
          style: theme.textTheme.titleLarge,
        ),
      ],
    );
  }
}
