import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

/// 음성 인식 초기화 결과
enum SpeechInitResult {
  success,
  permissionDenied,
  notAvailable,
  error,
}

/// speech_to_text 래퍼 (스페인어 발화 인식 전용)
///
/// 싱글톤. 권한 요청 + 시작/중지/취소만 노출.
class SpeechService {
  static final SpeechService _instance = SpeechService._internal();
  factory SpeechService() => _instance;
  SpeechService._internal();

  static const String defaultLocale = 'es-ES';
  static const int listenDurationSeconds = 15;
  static const int pauseDurationSeconds = 3;

  final SpeechToText _speech = SpeechToText();
  bool _isInitialized = false;
  bool _isListening = false;
  SpeechInitResult? _lastInitResult;

  bool get isListening => _isListening;
  bool get isAvailable => _isInitialized;
  SpeechInitResult? get lastInitResult => _lastInitResult;

  Future<SpeechInitResult> initialize() async {
    if (_isInitialized) return SpeechInitResult.success;
    try {
      _isInitialized = await _speech.initialize(
        onError: _onError,
        onStatus: _onStatus,
        debugLogging: kDebugMode,
      );
      _lastInitResult = _isInitialized
          ? SpeechInitResult.success
          : SpeechInitResult.permissionDenied;
      return _lastInitResult!;
    } catch (e) {
      debugPrint('Speech initialization failed: $e');
      _lastInitResult = SpeechInitResult.error;
      return SpeechInitResult.error;
    }
  }

  Future<bool> hasPermission() => _speech.hasPermission;

  Future<bool> startListening({
    required void Function(String text, bool isFinal) onResult,
    void Function(SpeechInitResult)? onPermissionError,
    void Function(String)? onError,
    String locale = defaultLocale,
  }) async {
    if (!_isInitialized) {
      final result = await initialize();
      if (result != SpeechInitResult.success) {
        onPermissionError?.call(result);
        return false;
      }
    }
    if (_isListening) return true;
    _isListening = true;
    try {
      await _speech.listen(
        onResult: (r) => onResult(r.recognizedWords, r.finalResult),
        localeId: locale,
        listenFor: const Duration(seconds: listenDurationSeconds),
        pauseFor: const Duration(seconds: pauseDurationSeconds),
        listenOptions: SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
        ),
      );
      return true;
    } catch (e) {
      debugPrint('Speech listen error: $e');
      _isListening = false;
      onError?.call(e.toString());
      return false;
    }
  }

  Future<void> stopListening() async {
    if (!_isListening) return;
    await _speech.stop();
    _isListening = false;
  }

  Future<void> cancelListening() async {
    await _speech.cancel();
    _isListening = false;
  }

  void _onError(SpeechRecognitionError error) {
    debugPrint('Speech error: ${error.errorMsg}');
    _isListening = false;
  }

  void _onStatus(String status) {
    debugPrint('Speech status: $status');
    if (status == 'done' || status == 'notListening') {
      _isListening = false;
    }
  }
}
