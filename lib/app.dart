import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/main/main_shell.dart';
import 'l10n/app_localizations.dart';

class EspanolBiteApp extends ConsumerWidget {
  const EspanolBiteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)?.appTitle ?? 'Español Bite',
      debugShowCheckedModeBanner: false,

      // 테마
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // 다국어 설정
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

      home: const MainShell(),
    );
  }
}
