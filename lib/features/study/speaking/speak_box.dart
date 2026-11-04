import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/providers/tts_providers.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/speech_service.dart';
import '../../speaking_practice/utils/text_similarity.dart';

/// 1.6.0 «모든 문제에 말하기» — 답한 뒤 그 문제의 스페인어 문장을 듣고 소리 내 말하는 상자.
///
///   듣기     🔊 보통 · 🐢 느리게(설정 속도의 0.7배) · 녹음 중 누르면 녹음을 멈추고 재생
///   말하기   speak_start · speak_end 효과음 · 결과 = % + 세 단계
///            🟢 80%+ 통과(정답 효과음) · 🟡 60~79 아깝다 · 🔴 60 미만 다시
///   다시     듣기 → 말하기 무제한 · 건너뛰기 있음
///   🔴 말하기는 문제 정답 판정에 섞지 않는다 — 결과는 [onResult] 로 기록만 넘긴다
class SpeakBox extends ConsumerStatefulWidget {
  final String questionId;
  final String target;
  final void Function(double best, int tries)? onResult;
  final VoidCallback? onSkip;

  const SpeakBox({
    super.key,
    required this.questionId,
    required this.target,
    this.onResult,
    this.onSkip,
  });

  @override
  ConsumerState<SpeakBox> createState() => _SpeakBoxState();
}

class _SpeakBoxState extends ConsumerState<SpeakBox> {
  bool _listening = false;
  String _heard = '';
  double? _score;
  double _best = 0;
  int _tries = 0;

  @override
  void dispose() {
    if (_listening) SpeechService().cancelListening();
    super.dispose();
  }

  Future<void> _play({bool slow = false}) async {
    if (_listening) {
      await SpeechService().stopListening();
      if (mounted) setState(() => _listening = false);
    }
    final tts = ref.read(ttsServiceProvider);
    final rate = await ref.read(ttsSpeechRateProvider.future);
    if (slow) await tts.setSpeechRate(rate * 0.7);
    await tts.speak(widget.target);
    if (slow) {
      // 다음 재생은 설정 속도로 — 느린 재생이 끝난 뒤 되돌린다(바로 되돌리면 iOS 가 말하는 중 속도를 바꾼다)
      Future.delayed(
        const Duration(milliseconds: 300),
        () => tts.setSpeechRate(rate),
      );
    }
  }

  Future<void> _toggleSay() async {
    final speech = SpeechService();
    final feedback = ref.read(feedbackServiceProvider);
    if (_listening) {
      await speech.stopListening();
      if (mounted) setState(() => _listening = false);
      return;
    }
    await ref.read(ttsServiceProvider).stop();
    await feedback.playSpeakStart();
    if (!mounted) return;
    setState(() {
      _listening = true;
      _heard = '';
      _score = null;
    });
    await speech.startListening(
      onResult: (text, isFinal) {
        if (!mounted) return;
        setState(() => _heard = text);
        if (!isFinal) return;
        final s = TextSimilarity.calculate(text, widget.target);
        feedback.playSpeakEnd();
        if (TextSimilarity.isPass(s)) feedback.playCorrect();
        setState(() {
          _listening = false;
          _score = s;
          _tries++;
          if (s > _best) _best = s;
        });
        widget.onResult?.call(_best, _tries);
        // 🗂 기록 — 시도 한 번 = 한 줄 · 옛 말하기 표를 그대로 쓴다(스키마 안 바꿈) · seedId = 문제 번호 · mode = 'quiz'
        //    문제마다 최고 % · 통과 · 시도 수는 이 줄들에서 센다(1.7.0 진행률 · 오답노트가 읽는다)
        AppDatabase().speakingRecordsDao.insertRecord(
          SpeakingRecordsCompanion(
            seedId: d.Value(widget.questionId),
            cardId: d.Value('q::${widget.questionId}'),
            mode: const d.Value('quiz'),
            spokenText: d.Value(text),
            targetText: d.Value(widget.target),
            accuracy: d.Value(s),
            passed: d.Value(TextSimilarity.isPass(s)),
          ),
        );
      },
      onPermissionError: (_) =>
          mounted ? setState(() => _listening = false) : null,
      onError: (_) => mounted ? setState(() => _listening = false) : null,
    );
  }

  String _label(AppLocalizations l10n, double s) => s >= 0.8
      ? l10n.speakPass
      : s >= 0.6
      ? l10n.speakAlmost
      : l10n.speakTryAgain;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(l10n.quizSayIt, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(
            widget.target,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                key: const Key('speak-play'),
                onPressed: _play,
                icon: const Icon(Icons.volume_up),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                key: const Key('speak-mic'),
                iconSize: 28,
                onPressed: _toggleSay,
                icon: Icon(_listening ? Icons.stop : Icons.mic),
              ),
              const SizedBox(width: 8),
              IconButton(
                key: const Key('speak-slow'),
                onPressed: () => _play(slow: true),
                icon: const Icon(Icons.slow_motion_video),
              ),
            ],
          ),
          if (_heard.isNotEmpty) Text(_heard, textAlign: TextAlign.center),
          if (_score != null) ...[
            Text(
              TextSimilarity.toPercent(_score!),
              style: theme.textTheme.titleLarge?.copyWith(
                color: TextSimilarity.colorOf(_score!),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(_label(l10n, _score!), style: theme.textTheme.bodySmall),
          ],
          if (widget.onSkip != null &&
              (_score == null || !TextSimilarity.isPass(_score!)))
            TextButton(onPressed: widget.onSkip, child: Text(l10n.speakSkip)),
        ],
      ),
    );
  }
}
