import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/markdown_utils.dart';
import '../../data/models/topic.dart';
import '../../data/providers/topic_providers.dart';
import '../../l10n/app_localizations.dart';
import '../study/widgets/tts_button.dart';

class TopicDetailScreen extends ConsumerWidget {
  final String topicId;

  const TopicDetailScreen({super.key, required this.topicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final topicAsync = ref.watch(topicByIdProvider(topicId));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.topicList),
      ),
      body: topicAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.error(e.toString()))),
        data: (topic) {
          if (topic == null) return const SizedBox.shrink();
          return _buildContent(context, topic);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Topic topic) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 토픽 제목
          Text(
            topic.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          // 스페인어 제목 + TTS
          if (topic.titleEs != null && topic.titleEs!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    topic.titleEs!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.outline,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                TtsButton(text: topic.titleEs!),
              ],
            ),
          ],

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // 이론 내용
          if (topic.theory.isNotEmpty)
            MarkdownBody(
              data: fixMarkdownBold(topic.theory),
              inlineSyntaxes: markdownInlineSyntaxes,
              styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                p: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
              ),
              shrinkWrap: true,
              softLineBreak: true,
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
                            TtsButton(text: vocab.word, iconSize: 18),
                            if (vocab.pronunciation != null) ...[
                              const SizedBox(width: 4),
                              Text(
                                vocab.pronunciation!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.outline,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(vocab.meaning),
                        if (vocab.example != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  vocab.example!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: theme.colorScheme.outline,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              TtsButton(text: vocab.example!, iconSize: 16),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                )),
          ],

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
