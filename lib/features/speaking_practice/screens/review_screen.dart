import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/premium_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/ad_service.dart';
import '../../../services/feedback_service.dart';
import '../../../services/speech_service.dart';
import '../../../services/tts_service.dart';
import '../data/speaking_models.dart';
import '../utils/spanish_numbers.dart';
import '../utils/speaking_l10n.dart';
import '../utils/speaking_palette.dart';
import '../utils/text_similarity.dart';
import '../widgets/permission_denied_dialog.dart';
import 'result_screen.dart';

/// 복습 카드를 (카드 + seedId) 형태로 묶은 단위.
class _ReviewItem {
  final SpeakingCard card;
  final String seedId;
  _ReviewItem({required this.card, required this.seedId});
}

/// 말하기 복습 — `nextReviewAt <= now`인 카드들을 모아서 발화 연습.
///
/// 연습 모드와 동일한 UX이나, 카드 출처가 여러 시드에 걸칠 수 있음.
class SpeakingReviewScreen extends ConsumerStatefulWidget {
  const SpeakingReviewScreen({super.key});

  @override
  ConsumerState<SpeakingReviewScreen> createState() =>
      _SpeakingReviewScreenState();
}

class _SpeakingReviewScreenState
    extends ConsumerState<SpeakingReviewScreen> {
  final TtsService _tts = TtsService();
  final SpeechService _speech = SpeechService();
  final List<AttemptResult> _results = [];

  late Future<List<_ReviewItem>> _loadFuture;
  List<_ReviewItem> _items = [];

  int _index = 0;
  String _spoken = '';
  double? _accuracy;
  bool _listening = false;
  bool _showMeaning = false;
  String? _errorMessage;

  _ReviewItem? get _current =>
      (_index < _items.length) ? _items[_index] : null;

  @override
  void initState() {
    super.initState();
    _loadFuture = _loadDueCards();
  }

  @override
  void dispose() {
    _speech.cancelListening();
    _tts.stop();
    super.dispose();
  }

  Future<List<_ReviewItem>> _loadDueCards() async {
    final db = AppDatabase();
    final dueProgress = await db.speakingProgressDao.getReviewDue();
    if (dueProgress.isEmpty) return [];

    // 모든 시드 로드 → cardId로 카드 조회
    final seeds = await SpeakingSeedLoader.loadAll();
    final cardIndex = <String, ({SpeakingCard card, String seedId})>{};
    for (final seed in seeds) {
      for (final c in seed.cards) {
        cardIndex[c.id] = (card: c, seedId: seed.id);
      }
    }

    final items = <_ReviewItem>[];
    for (final p in dueProgress) {
      final found = cardIndex[p.cardId];
      if (found != null) {
        items.add(_ReviewItem(card: found.card, seedId: found.seedId));
      }
    }
    return items;
  }

  /// 정답 음성 재생. 녹음 중이면 먼저 중단 — TTS 출력이 마이크에 들어가
  /// 정확도를 오인시키는 문제를 방지.
  Future<void> _playModel() async {
    if (_current == null) return;
    if (_listening) {
      await _speech.stopListening();
      if (mounted) setState(() => _listening = false);
    }
    await _tts.speak(_current!.card.es);
  }

  Future<void> _toggleListen(AppLocalizations l10n) async {
    if (_current == null) return;
    if (_listening) {
      await _speech.stopListening();
      setState(() => _listening = false);
      return;
    }
    setState(() {
      _spoken = '';
      _accuracy = null;
      _errorMessage = null;
    });
    await FeedbackService().playSpeakStart();
    final ok = await _speech.startListening(
      locale: SpeechService.defaultLocale,
      onResult: (text, isFinal) {
        setState(() => _spoken = text);
        if (isFinal) _evaluate(text);
      },
      onPermissionError: (_) {
        setState(() => _listening = false);
        if (mounted) PermissionDeniedDialog.show(context);
      },
      onError: (e) {
        setState(() {
          _listening = false;
          _errorMessage = l10n.speechError(e);
        });
      },
    );
    if (ok) {
      setState(() => _listening = true);
    }
  }

  Future<void> _evaluate(String text) async {
    FeedbackService().playSpeakEnd();
    final item = _current!;
    final acc = TextSimilarity.calculate(text, item.card.es);
    setState(() {
      _accuracy = acc;
      _listening = false;
    });
    _results.add(AttemptResult(card: item.card, spoken: text, accuracy: acc));
    final db = AppDatabase();
    await db.speakingRecordsDao.insertRecord(
      SpeakingRecordsCompanion(
        seedId: d.Value(item.seedId),
        cardId: d.Value(item.card.id),
        mode: const d.Value('review'),
        spokenText: d.Value(text),
        targetText: d.Value(item.card.es),
        accuracy: d.Value(acc),
        passed: d.Value(TextSimilarity.isPass(acc)),
      ),
    );
    await db.speakingProgressDao.updateFromAccuracy(
      cardId: item.card.id,
      seedId: item.seedId,
      accuracy: acc,
    );
  }

  void _next() {
    if (_index >= _items.length - 1) {
      _finish();
      return;
    }
    setState(() {
      _index++;
      _spoken = '';
      _accuracy = null;
      _showMeaning = false;
      _errorMessage = null;
    });
  }

  void _retry() {
    setState(() {
      _spoken = '';
      _accuracy = null;
      _errorMessage = null;
    });
  }

  void _finish() {
    final l10n = AppLocalizations.of(context)!;
    final isPremium = ref.read(isPremiumProvider);
    if (!isPremium) {
      AdService().showInterstitialAd();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SpeakingResultScreen(
          seedTitle: l10n.speakingReview,
          results: _results,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.speakingReview)),
      body: FutureBuilder<List<_ReviewItem>>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(l10n.loadFailedError(snapshot.error.toString())));
          }
          _items = snapshot.data ?? [];
          if (_items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        size: 64, color: Colors.green),
                    const SizedBox(height: 12),
                    Text(
                      l10n.noReviewDue,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          }
          return _buildSession(context, l10n);
        },
      ),
    );
  }

  Widget _buildSession(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    final accuracy = _accuracy;
    final item = _current!;
    final progress = (_index + 1) / _items.length;

    return Column(
      children: [
        LinearProgressIndicator(value: progress, minHeight: 4),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: SpeakingPalette.variationBadgeDecoration(),
                  child: Text(
                    variationLabel(l10n, item.card),
                    textAlign: TextAlign.center,
                    style: SpeakingPalette.variationBadgeText(context),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          item.card.es,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        IconButton.filled(
                          onPressed: _playModel,
                          icon: const Icon(Icons.volume_up),
                        ),
                        const SizedBox(height: 8),
                        if (_showMeaning)
                          Text(
                            item.card.translationFor(locale),
                            textAlign: TextAlign.center,
                            style: SpeakingPalette.meaningText(context),
                          )
                        else
                          TextButton(
                            onPressed: () =>
                                setState(() => _showMeaning = true),
                            child: Text(l10n.showMeaning),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_spoken.isNotEmpty)
                  Container(
                    decoration: accuracy != null
                        ? SpeakingPalette.accuracyDecoration(accuracy)
                        : BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest
                                .withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(16),
                          ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(l10n.iSaid,
                            style: SpeakingPalette.hintLabel(context)),
                        const SizedBox(height: 6),
                        // STT가 숫자 단어를 아라비아 숫자로 반환하는 경우 표시용 역치환.
                        Text(SpanishNumbers.digitsToWords(_spoken),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium),
                        if (accuracy != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            TextSimilarity.toPercent(accuracy),
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: SpeakingPalette.accuracyText(accuracy),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(accuracyFeedback(l10n, accuracy)),
                        ],
                      ],
                    ),
                  ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(_errorMessage!,
                        style: const TextStyle(color: Colors.red)),
                  ),
                ],
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => _toggleListen(l10n),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _listening
                          ? Colors.red
                          : theme.colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: (_listening
                                  ? Colors.red
                                  : theme.colorScheme.primary)
                              .withValues(alpha: 0.3),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      _listening ? Icons.stop : Icons.mic,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _listening ? l10n.listening : l10n.tapMicToSpeak,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                if (accuracy != null)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _retry,
                          child: Text(l10n.speakAgain),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: _next,
                          child: Text(
                            _index >= _items.length - 1
                                ? l10n.viewResult
                                : l10n.nextCard,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
