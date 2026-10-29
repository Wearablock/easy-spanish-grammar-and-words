import 'dart:math';

import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../data/speaking_models.dart';
import '../utils/speaking_palette.dart';
import 'speak_screen.dart';

/// 씨앗 문장 목록 — 세션 카드 수·난이도·검색 필터를 통해 원하는 씨앗을 골라
/// 말하기 세션을 시작하는 진입점.
class SpeakingSeedListScreen extends StatefulWidget {
  const SpeakingSeedListScreen({super.key});

  @override
  State<SpeakingSeedListScreen> createState() => _SpeakingSeedListScreenState();
}

class _SpeakingSeedListScreenState extends State<SpeakingSeedListScreen> {
  static const List<int> _sessionSizeOptions = [5, 10, 20];
  static const int _defaultSessionSize = 10;

  /// `null` = 전체 레벨.
  static const List<String?> _levelOptions = [null, 'A1', 'A2', 'B1'];

  late Future<List<SpeakingSeed>> _future;
  int _sessionSize = _defaultSessionSize;
  String? _levelFilter;
  String _searchQuery = '';

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
      appBar: AppBar(title: Text(l10n.speakingPractice)),
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
          final filtered = _applyFilters(seeds, locale);
          return Column(
            children: [
              _buildSessionSizePicker(context, l10n),
              _buildLevelFilter(context),
              _buildSearchBar(context),
              Expanded(
                child: filtered.isEmpty
                    ? Center(child: Text(l10n.noSeeds))
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, i) {
                          final seed = filtered[i];
                          final cardCount =
                              VariationGenerator.generate(seed).length;
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
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () => _open(seed),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 레벨·검색어에 따라 씨앗 목록을 필터링. 검색은 제목·베이스문장·번역을 모두 훑는다.
  List<SpeakingSeed> _applyFilters(List<SpeakingSeed> seeds, String locale) {
    final q = _searchQuery.trim().toLowerCase();
    return seeds.where((s) {
      if (_levelFilter != null && s.level != _levelFilter) return false;
      if (q.isEmpty) return true;
      final haystack = [
        s.titleFor(locale),
        s.baseEs,
        s.baseTranslationFor(locale),
        s.verb,
      ].join(' ').toLowerCase();
      return haystack.contains(q);
    }).toList();
  }

  Widget _buildSessionSizePicker(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          Text(l10n.cardsCount(_sessionSize),
              style: theme.textTheme.bodyMedium),
          const SizedBox(width: 12),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              children: _sessionSizeOptions.map((n) {
                return ChoiceChip(
                  label: Text('$n'),
                  selected: n == _sessionSize,
                  onSelected: (_) => setState(() => _sessionSize = n),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
      child: Row(
        children: [
          const Icon(Icons.filter_list, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 6,
              children: _levelOptions.map((lv) {
                final isAll = lv == null;
                return ChoiceChip(
                  label: Text(isAll ? 'All' : lv),
                  selected: _levelFilter == lv,
                  onSelected: (_) => setState(() => _levelFilter = lv),
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: TextField(
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: _searchQuery.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () => setState(() => _searchQuery = ''),
                ),
          hintText: AppLocalizations.of(context)!.searchHint,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
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
    final locale = Localizations.localeOf(context).toString();
    final all = VariationGenerator.generate(seed);
    final shuffled = [...all]..shuffle(Random());
    final picked = shuffled.take(_sessionSize).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpeakingSpeakScreen(
          title: seed.titleFor(locale),
          cards: picked,
        ),
      ),
    );
  }
}
