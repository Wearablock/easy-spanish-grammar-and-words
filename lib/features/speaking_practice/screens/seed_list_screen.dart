import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../data/speaking_models.dart';
import '../utils/speaking_palette.dart';
import 'practice_screen.dart';
import 'test_screen.dart';

/// 씨앗 문장 목록 — 연습 또는 테스트를 시작하는 진입점.
class SpeakingSeedListScreen extends StatefulWidget {
  final bool isTestMode;
  const SpeakingSeedListScreen({super.key, this.isTestMode = false});

  @override
  State<SpeakingSeedListScreen> createState() => _SpeakingSeedListScreenState();
}

class _SpeakingSeedListScreenState extends State<SpeakingSeedListScreen> {
  late Future<List<SpeakingSeed>> _future;

  @override
  void initState() {
    super.initState();
    _future = SpeakingSeedLoader.loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.isTestMode ? l10n.speakingTest : l10n.speakingPractice),
      ),
      body: FutureBuilder<List<SpeakingSeed>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(l10n.loadFailedError(snapshot.error.toString())));
          }
          final seeds = snapshot.data ?? [];
          if (seeds.isEmpty) {
            return Center(child: Text(l10n.noSeeds));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: seeds.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final seed = seeds[i];
              final cardCount = VariationGenerator.generate(seed).length;
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  title: Text(
                    seed.titleFor(locale),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(seed.baseTranslationFor(locale)),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 6,
                          children: [
                            _levelChip(seed.level),
                            _verbChip(seed.verb),
                            _countChip(l10n.cardsCount(cardCount)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _open(seed),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _levelChip(String level) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: SpeakingPalette.levelChipDecoration(level),
        child: Text(
          level,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: SpeakingPalette.levelChipText(level),
          ),
        ),
      );

  Widget _verbChip(String verb) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: SpeakingPalette.verbChipDecoration(),
        child: Text(
          verb,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: SpeakingPalette.verbChipText,
          ),
        ),
      );

  Widget _countChip(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: SpeakingPalette.countChipDecoration(),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: SpeakingPalette.countChipText,
          ),
        ),
      );

  void _open(SpeakingSeed seed) {
    final cards = VariationGenerator.generate(seed);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => widget.isTestMode
            ? SpeakingTestScreen(seed: seed, cards: cards)
            : SpeakingPracticeScreen(seed: seed, cards: cards),
      ),
    );
  }
}
