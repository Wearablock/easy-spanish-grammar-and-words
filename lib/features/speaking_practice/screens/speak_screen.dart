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

/// 말하기 — 번역을 보고 스페인어로 발화.
///
/// seed 비종속: 호출부에서 이미 선별한 카드 리스트를 받아서 그대로 진행한다.
/// (단일 씨앗 세션, 여러 씨앗 혼합 자동 세션 모두 지원)
/// 카드의 seedId는 `card.id` 의 `::` 앞부분에서 추출.
class SpeakingSpeakScreen extends ConsumerStatefulWidget {
  final String title;
  final List<SpeakingCard> cards;

  const SpeakingSpeakScreen({
    super.key,
    required this.title,
    required this.cards,
  });

  @override
  ConsumerState<SpeakingSpeakScreen> createState() =>
      _SpeakingSpeakScreenState();
}

class _SpeakingSpeakScreenState extends ConsumerState<SpeakingSpeakScreen> {
  final TtsService _tts = TtsService();
  final SpeechService _speech = SpeechService();
  final List<AttemptResult> _results = [];

  int _index = 0;
  String _spoken = '';
  double? _accuracy;
  bool _listening = false;
  bool _showAnswer = false;
  String? _errorMessage;

  SpeakingCard get _card => widget.cards[_index];
  String get _seedId => _card.id.split('::').first;

  @override
  void dispose() {
    _speech.cancelListening();
    _tts.stop();
    super.dispose();
  }

  /// 정답 음성 재생. 녹음 중이면 먼저 중단 — TTS 출력이 마이크에 들어가
  /// 정확도를 오인시키는 문제를 방지.
  Future<void> _playAnswer() async {
    if (_listening) {
      await _speech.stopListening();
      if (mounted) setState(() => _listening = false);
    }
    await _tts.speak(_card.es);
  }

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
        seedId: d.Value(_seedId),
        cardId: d.Value(_card.id),
        mode: const d.Value('practice'),
        spokenText: d.Value(text),
        targetText: d.Value(_card.es),
        accuracy: d.Value(acc),
        passed: d.Value(TextSimilarity.isPass(acc)),
      ),
    );
    await db.speakingProgressDao.updateFromAccuracy(
      cardId: _card.id,
      seedId: _seedId,
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
      _showAnswer = false;
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
    final isPremium = ref.read(isPremiumProvider);
    if (!isPremium) {
      AdService().showInterstitialAd();
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SpeakingResultScreen(
          seedTitle: widget.title,
          results: _results,
        ),
      ),
    );
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
            '${widget.title}  ${_index + 1}/${widget.cards.length}'),
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
                          const SizedBox(height: 16),
                          if (_showAnswer) ...[
                            Text(
                              _card.es,
                              textAlign: TextAlign.center,
                              style:
                                  theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            IconButton.filled(
                              onPressed: _playAnswer,
                              icon: const Icon(Icons.volume_up),
                            ),
                          ] else
                            TextButton.icon(
                              onPressed: () =>
                                  setState(() => _showAnswer = true),
                              icon: const Icon(
                                Icons.visibility_outlined,
                                size: 18,
                              ),
                              label: Text(l10n.correctAnswer),
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
                          // STT가 숫자 단어를 아라비아 숫자로 반환하는 경우(예: "20")
                          // 화면에는 스페인어 단어 형태("veinte")로 되돌려 보여준다.
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
                            if (!_showAnswer) ...[
                              const SizedBox(height: 8),
                              Text('${l10n.correctAnswerLabel}: ${_card.es}',
                                  style: theme.textTheme.bodyMedium),
                              IconButton(
                                onPressed: _playAnswer,
                                icon: const Icon(Icons.volume_up),
                              ),
                            ],
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
