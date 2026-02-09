import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 앱 설정 초기화 (버전 정보 등)
  await AppConfig.initialize();

  // TODO: Firebase 초기화 (flutterfire configure 후)
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // TODO: AdMob 초기화
  // await MobileAds.instance.initialize();

  // TODO: IAP 초기화
  // await IAPService().initialize();

  // TODO: 알림 서비스 초기화
  // await NotificationService().initialize();

  runApp(
    const ProviderScope(
      child: EspanolBiteApp(),
    ),
  );
}
