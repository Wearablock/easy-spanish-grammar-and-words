import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/setting_keys.dart';
import '../../data/providers/database_providers.dart';
import '../../data/providers/notification_providers.dart';
import '../../data/providers/topic_providers.dart';
import '../../l10n/app_localizations.dart';
import '../home/home_screen.dart';
import '../progress/progress_screen.dart';
import '../wrong_answers/wrong_answers_screen.dart';
import '../settings/settings_screen.dart';

class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell>
    with WidgetsBindingObserver {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ProgressScreen(),
    WrongAnswersScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initContentLocale();
  }

  /// 저장된 언어 설정으로 콘텐츠 로케일 초기화
  Future<void> _initContentLocale() async {
    final dao = ref.read(userSettingsDaoProvider);
    final saved = await dao.getLocale(); // 'system', 'ko', 'en', ...
    final option = LanguageOption.fromValue(saved);

    final String contentLocale;
    if (option.localeCode != null) {
      contentLocale = option.localeCode!;
    } else {
      // system: 기기 언어 기반 결정
      final deviceLang = PlatformDispatcher.instance.locale.languageCode;
      contentLocale = deviceLang == 'ko' ? 'ko' : 'en';
    }

    ref.read(currentLocaleProvider.notifier).state = contentLocale;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _rescheduleNotificationIfEnabled();
    }
  }

  Future<void> _rescheduleNotificationIfEnabled() async {
    final dao = ref.read(userSettingsDaoProvider);
    final enabled = await dao.getNotificationEnabled();
    if (enabled) {
      final service = ref.read(notificationServiceProvider);
      await service.reschedule();
    }
  }

  void _updateNotificationStrings(AppLocalizations l10n) {
    ref.read(notificationServiceProvider).setLocalizedStrings(
      channelName: l10n.notificationChannelName,
      channelDescription: l10n.notificationChannelDesc,
      notificationTitle: l10n.notificationTitle,
      motivationalMessages: [
        l10n.notificationMsg1,
        l10n.notificationMsg2,
        l10n.notificationMsg3,
        l10n.notificationMsg4,
        l10n.notificationMsg5,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _updateNotificationStrings(l10n);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: l10n.progress,
          ),
          NavigationDestination(
            icon: const Icon(Icons.error_outline),
            selectedIcon: const Icon(Icons.error),
            label: l10n.wrongAnswers,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.settings,
          ),
        ],
      ),
    );
  }
}
