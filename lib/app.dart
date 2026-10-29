import 'dart:io';
import 'dart:ui';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import 'core/theme/app_theme.dart';
import 'data/providers/database_providers.dart';
import 'features/main/main_shell.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'l10n/app_localizations.dart';

class EspanolBiteApp extends ConsumerWidget {
  const EspanolBiteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeModeProvider);
    final localeAsync = ref.watch(appLocaleProvider);

    final themeMode = themeAsync.value ?? ThemeMode.system;
    final locale = localeAsync.value;

    return MaterialApp(
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)?.appTitle ?? 'Easy Spanish',
      debugShowCheckedModeBanner: false,

      // 테마
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,

      // 다국어 설정
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
        Locale('ja'),
        Locale.fromSubtags(languageCode: 'zh'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        Locale('es'),
        Locale('pt'),
        Locale('de'),
        Locale('fr'),
        Locale('it'),
        Locale('ru'),
        Locale('ar'),
        Locale('th'),
        Locale('vi'),
        Locale('id'),
      ],

      // iPad: 폰 화면을 늘리지 않고 가운데 한 열로 (10-30 · 늘린 화면은 대부분 비어 보였다)
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        if (mq.size.width <= 700) return child!;
        const width = 640.0;
        return ColoredBox(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: SizedBox(
              width: width,
              child: MediaQuery(
                data: mq.copyWith(size: Size(width, mq.size.height)),
                child: child!,
              ),
            ),
          ),
        );
      },

      home: const _AppHome(),
    );
  }
}

class _AppHome extends ConsumerStatefulWidget {
  const _AppHome();

  @override
  ConsumerState<_AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends ConsumerState<_AppHome> {
  bool? _onboardingCompleted;

  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    final dao = ref.read(userSettingsDaoProvider);
    final completed = await dao.isOnboardingCompleted();

    // 온보딩 상태 확인 완료 → 네이티브 스플래시 제거
    FlutterNativeSplash.remove();

    if (mounted) {
      setState(() {
        _onboardingCompleted = completed;
      });
    }

    // iOS: 첫 화면이 렌더링된 후 ATT 권한 요청
    if (Platform.isIOS) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Future.delayed(const Duration(milliseconds: 500));
        await AppTrackingTransparency.requestTrackingAuthorization();
      });
    }
  }

  void _onOnboardingComplete() {
    setState(() {
      _onboardingCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_onboardingCompleted == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_onboardingCompleted!) {
      final countryCode = PlatformDispatcher.instance.locale.countryCode;

      return UpgradeAlert(
        upgrader: Upgrader(countryCode: countryCode),
        showIgnore: false,
        showLater: true,
        child: OnboardingScreen(
          onComplete: _onOnboardingComplete,
        ),
      );
    }

    final countryCode = PlatformDispatcher.instance.locale.countryCode;

    return UpgradeAlert(
      upgrader: Upgrader(countryCode: countryCode),
      showIgnore: false,
      showLater: true,
      child: const MainShell(),
    );
  }
}
