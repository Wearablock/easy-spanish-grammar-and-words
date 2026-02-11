import 'dart:io';

import 'package:flutter/foundation.dart';

/// 광고 설정
class AdConfig {
  AdConfig._();

  /// 스크린샷 모드 (true: 광고/디버그패널 숨김)
  static const bool screenshotMode = false;

  /// 광고 활성화 여부
  static bool get adsEnabled => !screenshotMode;

  /// 테스트 모드 여부 (릴리즈 빌드 시 자동으로 false)
  static bool get isTestMode => kDebugMode;

  // ============================================================
  // 전면 광고 설정
  // ============================================================

  static const int interstitialMinIntervalSeconds = 60;

  // ============================================================
  // 테스트 광고 ID (Google 공식 테스트 ID)
  // ============================================================

  static const String _testBannerIdAndroid =
      'ca-app-pub-3940256099942544/6300978111';
  static const String _testBannerIdIOS =
      'ca-app-pub-3940256099942544/2934735716';
  static const String _testInterstitialIdAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _testInterstitialIdIOS =
      'ca-app-pub-3940256099942544/4411468910';
  static const String _testRewardedIdAndroid =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _testRewardedIdIOS =
      'ca-app-pub-3940256099942544/1712485313';

  // ============================================================
  // 프로덕션 광고 ID (실제 ID로 교체 필요)
  // ============================================================

  static const String _prodBannerIdAndroid =
      'ca-app-pub-8841058711613546/1279953611';
  static const String _prodBannerIdIOS =
      'ca-app-pub-8841058711613546/2784606974';
  static const String _prodInterstitialIdAndroid =
      'ca-app-pub-8841058711613546/9533848151';
  static const String _prodInterstitialIdIOS =
      'ca-app-pub-8841058711613546/8743520402';
  static const String _prodRewardedIdAndroid =
      'ca-app-pub-8841058711613546/8966871943';
  static const String _prodRewardedIdIOS =
      'ca-app-pub-8841058711613546/7845361960';

  // ============================================================
  // 광고 ID Getter
  // ============================================================

  static String get bannerAdUnitId {
    if (isTestMode) {
      return Platform.isAndroid ? _testBannerIdAndroid : _testBannerIdIOS;
    }
    return Platform.isAndroid ? _prodBannerIdAndroid : _prodBannerIdIOS;
  }

  static String get interstitialAdUnitId {
    if (isTestMode) {
      return Platform.isAndroid
          ? _testInterstitialIdAndroid
          : _testInterstitialIdIOS;
    }
    return Platform.isAndroid
        ? _prodInterstitialIdAndroid
        : _prodInterstitialIdIOS;
  }

  static String get rewardedAdUnitId {
    if (isTestMode) {
      return Platform.isAndroid ? _testRewardedIdAndroid : _testRewardedIdIOS;
    }
    return Platform.isAndroid ? _prodRewardedIdAndroid : _prodRewardedIdIOS;
  }
}
