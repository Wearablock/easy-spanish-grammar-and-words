import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'services/ad_service.dart';
import 'services/notification_service.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 앱 설정 초기화 (버전 정보 등)
  await AppConfig.initialize();

  // TODO: Firebase 초기화 (flutterfire configure 후)
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // AdMob 초기화
  await MobileAds.instance.initialize();
  AdService().preloadAds();

  // TODO: IAP 초기화
  // await IAPService().initialize();

  // 알림 서비스 초기화
  await NotificationService().initialize();

  runApp(
    const ProviderScope(
      child: EspanolBiteApp(),
    ),
  );
}
