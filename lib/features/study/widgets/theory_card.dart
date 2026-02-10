import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/topic.dart';
import '../../../l10n/app_localizations.dart';

class TheoryCard extends ConsumerWidget {
  final Topic topic;
  final VoidCallback onCompleted;

  const TheoryCard({
    super.key,
    required this.topic,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이론 헤더 아이콘
          Row(
            children: [
              Icon(Icons.menu_book,
                  color: theme.colorScheme.secondary, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.newLearning,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 토픽 제목
          Text(
            topic.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          // 스페인어 제목 (있으면)
          if (topic.titleEs != null && topic.titleEs!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              topic.titleEs!,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // 이론 내용
          if (topic.theory.isNotEmpty)
            Text(
              topic.theory,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
            ),

          // 핵심 포인트
          if (topic.hasKeyPoints) ...[
            const SizedBox(height: 24),
            Text(
              l10n.keyPoints,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...topic.keyPoints!.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          )),
                      Expanded(child: Text(point)),
                    ],
                  ),
                )),
          ],

          // 어휘 목록
          if (topic.hasVocabList) ...[
            const SizedBox(height: 24),
            Text(
              l10n.vocabulary,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...topic.vocabList!.map((vocab) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                vocab.word,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                            if (vocab.pronunciation != null)
                              Text(
                                vocab.pronunciation!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(vocab.meaning),
                        if (vocab.example != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            vocab.example!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                )),
          ],

          const SizedBox(height: 32),

          // 학습 완료 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCompleted,
              child: Text(l10n.theoryComplete),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
