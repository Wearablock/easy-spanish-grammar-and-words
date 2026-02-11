import 'package:flutter_tts/flutter_tts.dart';

/// 사용 가능한 TTS 음성 정보
class TtsVoiceInfo {
  final String name;
  final String locale;

  const TtsVoiceInfo({required this.name, required this.locale});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TtsVoiceInfo && other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => name;
}

/// flutter_tts 래퍼 서비스 (스페인어 전용)
class TtsService {
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  TtsService() {
    _init();
  }

  Future<void> _init() async {
    await _tts.setLanguage('es-ES');
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    // iOS: 블루투스 및 믹스 지원
    await _tts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
      ],
      IosTextToSpeechAudioMode.voicePrompt,
    );

    _tts.setStartHandler(() => _isSpeaking = true);
    _tts.setCompletionHandler(() => _isSpeaking = false);
    _tts.setCancelHandler(() => _isSpeaking = false);
    _tts.setErrorHandler((_) => _isSpeaking = false);
  }

  /// 재생 속도 변경 (0.0 ~ 1.0)
  Future<void> setSpeechRate(double rate) async {
    await _tts.setSpeechRate(rate.clamp(0.0, 1.0));
  }

  /// 음성 변경 (name + locale)
  Future<void> setVoice(String name, String locale) async {
    await _tts.setVoice({'name': name, 'locale': locale});
  }

  /// 디바이스에서 사용 가능한 es-ES 음성 목록 조회
  Future<List<TtsVoiceInfo>> getSpanishVoices() async {
    final voices = await _tts.getVoices;
    if (voices == null) return [];

    final list = <TtsVoiceInfo>[];
    for (final v in voices) {
      final map = Map<String, String>.from(v as Map);
      final locale = map['locale'] ?? '';
      // es-ES, es_ES, es-MX 등 스페인어 음성 모두 포함
      if (locale.startsWith('es')) {
        list.add(TtsVoiceInfo(name: map['name'] ?? '', locale: locale));
      }
    }
    return list;
  }

  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    if (_isSpeaking) await stop();
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
    _isSpeaking = false;
  }

  Future<void> dispose() async {
    await stop();
    await _tts.stop();
  }
}
