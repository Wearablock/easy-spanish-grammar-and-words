import 'dart:async';
import 'services/content_store.dart';
import 'services/remote_content_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'services/ad_service.dart';
import 'services/iap_service.dart';
import 'services/notification_service.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 앱 설정 초기화 (버전 정보 등)
  await AppConfig.initialize();
  // 10-29 — 학습 데이터는 서버에서 받아 둔 것이 먼저(업데이트 없이 문제를 늘린다) · 받기는 뒤에서 조용히
  await ContentStore.init();
  unawaited(RemoteContentService.sync());

  // TODO: Firebase 초기화 (flutterfire configure 후)
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // AdMob 초기화 (ATT 요청은 첫 화면 렌더링 후 app.dart에서 처리)
  await MobileAds.instance.initialize();
  AdService().preloadAds();

  // IAP 초기화
  await IAPService().initialize();

  // 알림 서비스 초기화
  await NotificationService().initialize();

  runApp(const ProviderScope(child: EspanolBiteApp()));
}
