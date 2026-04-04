import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

/// 정답/오답 효과음 + 진동 피드백 서비스
class FeedbackService {
  static final FeedbackService _instance = FeedbackService._();
  factory FeedbackService() => _instance;
  FeedbackService._();

  final _player = AudioPlayer();
  final _random = Random();

  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _hasVibrator = false;

  /// 초기화 (앱 시작 시 1회)
  Future<void> init() async {
    _hasVibrator = (await Vibration.hasVibrator()) == true;
  }

  /// 설정 업데이트
  void updateSettings({required bool sound, required bool vibration}) {
    _soundEnabled = sound;
    _vibrationEnabled = vibration;
  }

  /// 정답 피드백
  Future<void> playCorrect() async {
    if (_soundEnabled) {
      final file = _random.nextBool() ? 'correct_male.mp3' : 'correct_female.mp3';
      await _player.play(AssetSource('sounds/$file'));
    }
    if (_vibrationEnabled && _hasVibrator) {
      Vibration.vibrate(duration: 50);
    }
  }

  /// 오답 피드백
  Future<void> playWrong() async {
    if (_soundEnabled) {
      final file = _random.nextBool() ? 'wrong_male.mp3' : 'wrong_female.mp3';
      await _player.play(AssetSource('sounds/$file'));
    }
    if (_vibrationEnabled && _hasVibrator) {
      Vibration.vibrate(pattern: [0, 80, 60, 80]);
    }
  }

  void dispose() {
    _player.dispose();
  }
}
