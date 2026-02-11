import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/study_providers.dart';
import '../../l10n/app_localizations.dart';
import '../study/study_session_screen.dart';
import 'widgets/wrong_answer_card.dart';

class WrongAnswersScreen extends ConsumerWidget {
  const WrongAnswersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final wrongAnswersAsync = ref.watch(wrongAnswersWithQuestionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.wrongAnswers),
      ),
      body: wrongAnswersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(l10n.error(e.toString()))),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.noWrongAnswers,
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.noWrongAnswersDesc,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return WrongAnswerCard(item: items[index]);
            },
          );
        },
      ),
      floatingActionButton: wrongAnswersAsync.whenOrNull(
        data: (items) {
          final ids = items
              .where((e) => e.question != null)
              .map((e) => e.wrongAnswer.questionId)
              .toList();
          if (ids.isEmpty) return null;
          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      StudySessionScreen(wrongAnswerIds: ids),
                ),
              );
            },
            icon: const Icon(Icons.replay),
            label: Text(l10n.wrongReview),
          );
        },
      ),
    );
  }
}
