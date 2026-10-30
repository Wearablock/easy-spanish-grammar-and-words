import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../data/providers/database_providers.dart';
import '../../data/providers/topic_providers.dart';
import '../../l10n/app_localizations.dart';
import 'topic_detail_screen.dart';
import '../../core/utils/level_label.dart';

class TopicListScreen extends ConsumerWidget {
  final String level;
  final String levelName;
  final Color levelColor;

  const TopicListScreen({
    super.key,
    required this.level,
    required this.levelName,
    required this.levelColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final grammarTopicsAsync =
        ref.watch(topicsByLevelProvider('grammar_$level'));
    final vocabTopicsAsync =
        ref.watch(topicsByLevelProvider('vocab_$level'));
    final studyRecordsAsync = ref.watch(studyRecordsByLevelProvider('grammar_$level'));
    final vocabRecordsAsync = ref.watch(studyRecordsByLevelProvider('vocab_$level'));

    return Scaffold(
      appBar: AppBar(
        title: Text('${levelLabel(level)} - $levelName'),
      ),
      body: grammarTopicsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.error(e.toString()))),
        data: (grammarTopics) {
          final vocabTopics = vocabTopicsAsync.value ?? [];
          final grammarRecords = studyRecordsAsync.value ?? [];
          final vocabRecords = vocabRecordsAsync.value ?? [];

          final studiedIds = {
            ...grammarRecords.map((r) => r.topicId),
            ...vocabRecords.map((r) => r.topicId),
          };

          final hasGrammar = grammarTopics.isNotEmpty;
          final hasVocab = vocabTopics.isNotEmpty;

          if (!hasGrammar && !hasVocab) {
            return Center(
              child: Text(
                l10n.noStudyYet,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            );
          }

          return DefaultTabController(
            length: (hasGrammar ? 1 : 0) + (hasVocab ? 1 : 0),
            child: Column(
              children: [
                if (hasGrammar && hasVocab)
                  TabBar(
                    tabs: [
                      if (hasGrammar) Tab(text: l10n.grammar),
                      if (hasVocab) Tab(text: l10n.vocabulary),
                    ],
                  ),
                Expanded(
                  child: TabBarView(
                    children: [
                      if (hasGrammar)
                        _buildTopicList(
                            context, grammarTopics, studiedIds, theme, l10n),
                      if (hasVocab)
                        _buildTopicList(
                            context, vocabTopics, studiedIds, theme, l10n),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopicList(
    BuildContext context,
    List topics,
    Set<String> studiedIds,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final topic = topics[index];
        final isStudied = studiedIds.contains(topic.id);

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TopicDetailScreen(topicId: topic.id),
                ),
              );
            },
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isStudied
                    ? AppColors.correct.withValues(alpha: 0.1)
                    : theme.colorScheme.outline.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isStudied ? Icons.check_circle : Icons.circle_outlined,
                color: isStudied
                    ? AppColors.correct
                    : theme.colorScheme.outline,
                size: 20,
              ),
            ),
            title: Text(
              topic.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: topic.titleEs != null && topic.titleEs!.isNotEmpty
                ? Text(
                    topic.titleEs!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : null,
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: theme.colorScheme.outline,
            ),
          ),
        );
      },
    );
  }
}
