import 'dart:math';

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

/// 말하기 테스트 — 힌트 없이 N개 무작위 출제, 한 번만 발화 기회.
///
/// 프롬프트: base 번역(현재 locale) + 변형 라벨 → 사용자가 Spanish로 발화.
class SpeakingTestScreen extends ConsumerStatefulWidget {
  final SpeakingSeed seed;
  final List<SpeakingCard> cards;
  const SpeakingTestScreen({
    super.key,
    required this.seed,
    required this.cards,
  });

  @override
  ConsumerState<SpeakingTestScreen> createState() =>
      _SpeakingTestScreenState();
}

class _SpeakingTestScreenState extends ConsumerState<SpeakingTestScreen> {
  static const int testQuestionCount = 5;
  static const int maxAttemptsPerCard = 2;

  final TtsService _tts = TtsService();
  final SpeechService _speech = SpeechService();
  final List<AttemptResult> _results = [];

  late final List<SpeakingCard> _quiz;
  int _index = 0;
  int _attemptIndex = 0; // 0 = 1차 시도, 1 = 재도전 (베스트 채택)
  AttemptResult? _bestAttempt; // 현재 카드의 베스트 결과
  String _spoken = '';
  double? _accuracy;
  bool _listening = false;
  bool _answered = false;
  String? _errorMessage;

  SpeakingCard get _card => _quiz[_index];
  bool get _hasRetryLeft => _attemptIndex < maxAttemptsPerCard - 1;

  @override
  void initState() {
    super.initState();
    final shuffled = [...widget.cards]..shuffle(Random());
    _quiz = shuffled.take(testQuestionCount).toList();
  }

  @override
  void dispose() {
    _speech.cancelListening();
    _tts.stop();
    super.dispose();
  }

  Future<void> _toggleListen(AppLocalizations l10n) async {
    if (_answered) return;
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
    final attempt = AttemptResult(card: _card, spoken: text, accuracy: acc);
    setState(() {
      _accuracy = acc;
      _listening = false;
      _answered = true;
      // Best of N: 베스트 점수 갱신
      if (_bestAttempt == null || acc > _bestAttempt!.accuracy) {
        _bestAttempt = attempt;
      }
    });
    // 모든 시도를 DB에 기록 (분석용)
    final db = AppDatabase();
    await db.speakingRecordsDao.insertRecord(
      SpeakingRecordsCompanion(
        seedId: d.Value(widget.seed.id),
        cardId: d.Value(_card.id),
        mode: const d.Value('test'),
        spokenText: d.Value(text),
        targetText: d.Value(_card.es),
        accuracy: d.Value(acc),
        passed: d.Value(TextSimilarity.isPass(acc)),
      ),
    );
    // SR 진도 업데이트 (테스트도 동일)
    await db.speakingProgressDao.updateFromAccuracy(
      cardId: _card.id,
      seedId: widget.seed.id,
      accuracy: acc,
    );
  }

  /// 발음 힌트 — 정답 음성을 TTS로 재생. Rewarded Ad 게이팅.
  /// 텍스트는 노출하지 않음 → 테스트 무결성 유지.
  Future<void> _onPlayHint() async {
    final isPremium = ref.read(isPremiumProvider);
    final adService = AdService();

    if (isPremium) {
      await _tts.speak(_card.es);
      return;
    }

    if (adService.isRewardedAdReady) {
      await adService.showRewardedAd(
        onRewarded: (_) async {
          await _tts.speak(_card.es);
        },
      );
      return;
    }
    final loaded = await adService.tryLoadRewardedAd();
    if (!mounted) return;
    if (loaded) {
      await adService.showRewardedAd(
        onRewarded: (_) async {
          await _tts.speak(_card.es);
        },
      );
    } else {
      // 폴백: 광고 로드 실패 시 광고 없이 재생
      await _tts.speak(_card.es);
    }
  }

  /// 재도전 — 같은 카드 내 시도 횟수만 증가, 베스트는 유지.
  void _retryAttempt() {
    setState(() {
      _attemptIndex++;
      _spoken = '';
      _accuracy = null;
      _answered = false;
      _errorMessage = null;
    });
  }

  void _next() {
    // 베스트 결과를 결과 리스트에 확정 push
    if (_bestAttempt != null) {
      _results.add(_bestAttempt!);
    }
    if (_index >= _quiz.length - 1) {
      _finish();
      return;
    }
    setState(() {
      _index++;
      _attemptIndex = 0;
      _bestAttempt = null;
      _spoken = '';
      _accuracy = null;
      _answered = false;
      _errorMessage = null;
    });
  }

  void _finish() {
    final locale = Localizations.localeOf(context).toString();
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
          isTestMode: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final progress = (_index + 1) / _quiz.length;
    final accuracy = _accuracy;

    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.speakingTest}  ${_index + 1}/${_quiz.length}'),
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
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            l10n.sayInSpanishHint,
                            style: SpeakingPalette.hintLabel(context),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _card.translationFor(locale),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration:
                                SpeakingPalette.variationBadgeDecoration(),
                            child: Text(
                              variationLabel(l10n, _card),
                              style:
                                  SpeakingPalette.variationBadgeText(context),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.attemptCounter(
                                _attemptIndex + 1, maxAttemptsPerCard),
                            style: SpeakingPalette.hintLabel(context),
                          ),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: _answered ? null : _onPlayHint,
                            icon: const Icon(Icons.volume_up, size: 18),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(l10n.playHint),
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
                          Text(_spoken, style: theme.textTheme.titleMedium),
                          if (accuracy != null) ...[
                            const SizedBox(height: 12),
                            Text(
                              TextSimilarity.toPercent(accuracy),
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: SpeakingPalette.accuracyText(accuracy),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('${l10n.correctAnswerLabel}: ${_card.es}',
                                style: theme.textTheme.bodyMedium),
                            IconButton(
                              onPressed: () => _tts.speak(_card.es),
                              icon: const Icon(Icons.volume_up),
                            ),
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
                        color: _answered
                            ? SpeakingPalette.disabledMicColor(context)
                            : (_listening
                                ? Colors.red
                                : theme.colorScheme.primary),
                      ),
                      child: Icon(
                        _listening ? Icons.stop : Icons.mic,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_answered)
                    Row(
                      children: [
                        if (_hasRetryLeft) ...[
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _retryAttempt,
                              child: Text(l10n.speakAgain),
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: FilledButton(
                            onPressed: _next,
                            child: Text(
                              _index >= _quiz.length - 1
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
