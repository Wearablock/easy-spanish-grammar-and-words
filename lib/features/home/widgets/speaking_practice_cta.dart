import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../speaking_practice/data/speaking_review_provider.dart';
import '../../speaking_practice/screens/seed_list_screen.dart';
import '../../speaking_practice/screens/speak_screen.dart';

/// 홈 화면 — 말하기 진입 카드.
///
/// 메인 버튼은 자동 세션(복습 대기 + 새 카드 혼합) 시작.
/// 보조 링크로 씨앗 직접 선택 플로우 유지.
class SpeakingPracticeCta extends ConsumerStatefulWidget {
  const SpeakingPracticeCta({super.key});

  @override
  ConsumerState<SpeakingPracticeCta> createState() =>
      _SpeakingPracticeCtaState();
}

class _SpeakingPracticeCtaState extends ConsumerState<SpeakingPracticeCta> {
  static const List<int> _sessionSizeOptions = [5, 10, 20];
  static const int _defaultSessionSize = 10;
  static const Color _goldDeep = Color(0xFF6B4E00);

  int _sessionSize = _defaultSessionSize;
  bool _starting = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withValues(alpha: 0.22),
            AppColors.secondary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.45),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -8,
            top: -4,
            child: Icon(
              Icons.mic,
              size: 96,
              color: AppColors.secondary.withValues(alpha: 0.18),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'NUEVO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(Icons.mic, color: _goldDeep, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      l10n.speakingPractice,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _goldDeep,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(right: 56),
                  child: Text(
                    l10n.speakingFeatureDesc,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _goldDeep.withValues(alpha: 0.78),
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      l10n.cardsCount(_sessionSize),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _goldDeep.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 6,
                        children: _sessionSizeOptions.map((n) {
                          final selected = n == _sessionSize;
                          return ChoiceChip(
                            label: Text('$n'),
                            selected: selected,
                            onSelected: (_) =>
                                setState(() => _sessionSize = n),
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _starting ? null : _startAuto,
                  icon: _starting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.mic, size: 18),
                  label: Text(l10n.start),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: _goldDeep,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _openSeedList,
                    icon: const Icon(Icons.menu_book_outlined, size: 14),
                    label: Text(
                      l10n.speakingBrowseAll,
                      style: const TextStyle(fontSize: 12),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: _goldDeep.withValues(alpha: 0.85),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startAuto() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _starting = true);
    final cards = await SpeakingAutoSession.build(size: _sessionSize);
    if (!mounted) return;
    setState(() => _starting = false);

    if (cards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.noReviewDue)),
      );
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SpeakingSpeakScreen(
          title: l10n.speakingPractice,
          cards: cards,
        ),
      ),
    );
    // 세션 결과가 복습 대기 카운트에 영향 → refresh.
    if (mounted) {
      ref.invalidate(speakingReviewDueCountProvider);
    }
  }

  void _openSeedList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const SpeakingSeedListScreen(),
      ),
    );
  }
}
