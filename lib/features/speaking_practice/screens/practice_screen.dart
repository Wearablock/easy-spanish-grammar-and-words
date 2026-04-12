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
import '../utils/speaking_l10n.dart';
import '../utils/speaking_palette.dart';
import '../utils/text_similarity.dart';
import '../widgets/permission_denied_dialog.dart';
import 'result_screen.dart';

/// 말하기 연습 — 카드별 모범 음성 듣기 → 따라말하기 → 정확도 피드백.
class SpeakingPracticeScreen extends ConsumerStatefulWidget {
  final SpeakingSeed seed;
  final List<SpeakingCard> cards;
  const SpeakingPracticeScreen({
    super.key,
    required this.seed,
    required this.cards,
  });

  @override
  ConsumerState<SpeakingPracticeScreen> createState() =>
      _SpeakingPracticeScreenState();
}

class _SpeakingPracticeScreenState
    extends ConsumerState<SpeakingPracticeScreen> {
  final TtsService _tts = TtsService();
  final SpeechService _speech = SpeechService();
  final List<AttemptResult> _results = [];

  int _index = 0;
  String _spoken = '';
  double? _accuracy;
  bool _listening = false;
  bool _showMeaning = false;
  String? _errorMessage;

  SpeakingCard get _card => widget.cards[_index];

  @override
  void dispose() {
    _speech.cancelListening();
    _tts.stop();
    super.dispose();
  }

  Future<void> _playModel() => _tts.speak(_card.es);

  Future<void> _toggleListen(AppLocalizations l10n) async {
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
    final acc = TextSimilarity.calculate(text, _card.es);
    setState(() {
      _accuracy = acc;
      _listening = false;
    });
    _results.add(AttemptResult(card: _card, spoken: text, accuracy: acc));
    final db = AppDatabase();
    await db.speakingRecordsDao.insertRecord(
      SpeakingRecordsCompanion(
        seedId: d.Value(widget.seed.id),
        cardId: d.Value(_card.id),
        mode: const d.Value('practice'),
        spokenText: d.Value(text),
        targetText: d.Value(_card.es),
        accuracy: d.Value(acc),
        passed: d.Value(TextSimilarity.isPass(acc)),
      ),
    );
    // SR 진도 업데이트 (통과 → level+1, 미달 → level 0 + 내일 복습)
    await db.speakingProgressDao.updateFromAccuracy(
      cardId: _card.id,
      seedId: widget.seed.id,
      accuracy: acc,
    );
  }

  void _next() {
    if (_index >= widget.cards.length - 1) {
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
    final locale = Localizations.localeOf(context).toString();
    // 세션 종료 시 전면 광고 (학습 세션과 동일 패턴, 60→150초 쿨타임 적용)
    final isPremium = ref.read(isPremiumProvider);
    if (!isPremium) {
      AdService().showInterstitialAd();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SpeakingResultScreen(
          seedTitle: widget.seed.titleFor(locale),
          results: _results,
          isTestMode: false,
        ),
      ),
    );
  }

  /// "뜻 보기" — 보상형 광고 시청 후 노출 (프리미엄은 광고 없이 즉시).
  /// quiz_card.dart의 힌트 패턴과 동일.
  Future<void> _onShowMeaning() async {
    final isPremium = ref.read(isPremiumProvider);
    final adService = AdService();

    if (isPremium) {
      setState(() => _showMeaning = true);
      return;
    }

    if (adService.isRewardedAdReady) {
      await adService.showRewardedAd(
        onRewarded: (_) {
          if (mounted) setState(() => _showMeaning = true);
        },
      );
      return;
    }
    final loaded = await adService.tryLoadRewardedAd();
    if (!mounted) return;
    if (loaded) {
      await adService.showRewardedAd(
        onRewarded: (_) {
          if (mounted) setState(() => _showMeaning = true);
        },
      );
    } else {
      // 폴백: 광고 로드 실패 시 광고 없이 표시 (UX 우선)
      setState(() => _showMeaning = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final progress = (_index + 1) / widget.cards.length;
    final accuracy = _accuracy;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.seed.titleFor(locale)}  ${_index + 1}/${widget.cards.length}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
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
                      variationLabel(l10n, _card),
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
                            _card.es,
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
                              _card.translationFor(locale),
                              textAlign: TextAlign.center,
                              style: SpeakingPalette.meaningText(context),
                            )
                          else
                            TextButton(
                              onPressed: _onShowMeaning,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(l10n.showMeaning),
                                  if (!ref.watch(isPremiumProvider)) ...[
                                    const SizedBox(width: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.secondary
                                            .withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'AD',
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: theme.colorScheme.secondary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
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
                          Text(_spoken,
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
                              _index >= widget.cards.length - 1
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
      ),
    );
  }
}
