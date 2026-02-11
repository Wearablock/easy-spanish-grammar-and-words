import 'package:package_info_plus/package_info_plus.dart';

/// 앱 전역 설정
class AppConfig {
  AppConfig._();

  static PackageInfo? _packageInfo;

  /// 앱 초기화 시 호출 (main.dart에서)
  static Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  // ============================================================
  // 앱 정보
  // ============================================================

  static String get appName => _packageInfo?.appName ?? 'Easy Spanish';
  static String get packageName => _packageInfo?.packageName ?? '';
  static String get version => _packageInfo?.version ?? '1.0.0';
  static String get buildNumber => _packageInfo?.buildNumber ?? '1';
  static String get fullVersion => '$version+$buildNumber';

  // ============================================================
  // 앱 모드 설정
  // ============================================================

  /// 심사 모드 (스토어 심사 시 true로 변경)
  static const bool isReviewMode = false;

  /// 디버그 모드
  static const bool isDebugMode = true;

  // ============================================================
  // 지원 언어
  // ============================================================

  static const List<String> supportedLocales = [
    'ko',
    'en',
    'ja',
    'zh-Hans',
    'zh-Hant',
    'es',
    'pt',
  ];

  // ============================================================
  // 외부 URL
  // ============================================================

  static const String _baseUrl =
      'https://wearablock.github.io/easy-spanish-grammar-and-words';
  static const String termsUrl = '$_baseUrl/terms.html';
  static const String privacyUrl = '$_baseUrl/privacy.html';
  static const String supportUrl = '$_baseUrl/support.html';
}
