import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';

import 'core/theme/app_theme.dart';
import 'data/providers/database_providers.dart';
import 'features/main/main_shell.dart';
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
          AppLocalizations.of(context)?.appTitle ?? 'Español Bite',
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

      home: UpgradeAlert(
        showIgnore: false,
        showLater: true,
        child: const MainShell(),
      ),
    );
  }
}
