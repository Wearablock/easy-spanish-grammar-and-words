import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/tts_service.dart';
import 'database_providers.dart';

/// TtsService 싱글톤 인스턴스 (저장된 설정 자동 적용)
final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TtsService();
  ref.onDispose(() => service.dispose());

  // 저장된 속도/음성 설정을 비동기로 적용
  final dao = ref.read(userSettingsDaoProvider);
  Future(() async {
    final rate = await dao.getTtsSpeechRate();
    await service.setSpeechRate(rate);

    final voiceName = await dao.getTtsVoice();
    if (voiceName != null) {
      final voices = await service.getSpanishVoices();
      final match = voices.where((v) => v.name == voiceName);
      if (match.isNotEmpty) {
        await service.setVoice(match.first.name, match.first.locale);
      }
    }
  });

  return service;
});

/// TTS 자동재생 설정 (DAO에서 읽기)
final ttsAutoPlayProvider = FutureProvider<bool>((ref) async {
  final dao = ref.watch(userSettingsDaoProvider);
  return dao.getTtsAutoPlay();
});

/// TTS 재생 속도 설정 (DAO에서 읽기)
final ttsSpeechRateProvider = FutureProvider<double>((ref) async {
  final dao = ref.watch(userSettingsDaoProvider);
  return dao.getTtsSpeechRate();
});

/// TTS 선택된 음성 이름 (DAO에서 읽기, null = 시스템 기본)
final ttsVoiceProvider = FutureProvider<String?>((ref) async {
  final dao = ref.watch(userSettingsDaoProvider);
  return dao.getTtsVoice();
});

/// 디바이스에서 사용 가능한 스페인어 음성 목록
final ttsAvailableVoicesProvider =
    FutureProvider<List<TtsVoiceInfo>>((ref) async {
  final service = ref.watch(ttsServiceProvider);
  return service.getSpanishVoices();
});
