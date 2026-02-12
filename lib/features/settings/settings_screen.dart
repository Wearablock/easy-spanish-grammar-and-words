import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/app_config.dart';
import '../../core/config/constants.dart';
import '../../core/config/setting_keys.dart';
import '../../core/theme/app_colors.dart';
import '../../data/providers/database_providers.dart';
import '../../data/providers/premium_provider.dart';
import '../../data/providers/study_providers.dart';
import '../../data/providers/topic_providers.dart';
import '../../data/providers/notification_providers.dart';
import '../../data/providers/tts_providers.dart';
import '../../l10n/app_localizations.dart';
import '../../services/iap_service.dart';
import '../../services/tts_service.dart';
import 'webview_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  String _targetLevel = LevelConstants.defaultTargetLevel;
  int _dailyGoal = StudyConstants.defaultDailyGoal;
  bool _notificationEnabled = false;
  String _locale = 'system';
  String _themeMode = 'system';
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _ttsAutoPlay = false;
  double _ttsSpeechRate = 0.45;
  String? _ttsVoice;
  List<TtsVoiceInfo> _ttsVoices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final dao = ref.read(userSettingsDaoProvider);
    final ttsService = ref.read(ttsServiceProvider);
    final results = await Future.wait([
      dao.getTargetLevel(),
      dao.getDailyGoal(),
      dao.getNotificationEnabled(),
      dao.getLocale(),
      dao.getThemeMode(),
      dao.getSoundEnabled(),
      dao.getVibrationEnabled(),
      dao.getTtsAutoPlay(),
      dao.getTtsSpeechRate(),
      dao.getTtsVoice(),
      ttsService.getSpanishVoices(),
    ]);

    if (mounted) {
      setState(() {
        _targetLevel = results[0] as String;
        _dailyGoal = results[1] as int;
        _notificationEnabled = results[2] as bool;
        _locale = results[3] as String;
        _themeMode = results[4] as String;
        _soundEnabled = results[5] as bool;
        _vibrationEnabled = results[6] as bool;
        _ttsAutoPlay = results[7] as bool;
        _ttsSpeechRate = results[8] as double;
        _ttsVoice = results[9] as String?;
        _ttsVoices = results[10] as List<TtsVoiceInfo>;
        _isLoading = false;
      });
    }
  }

  void _openWebView(String title, String url) {
    final locale = Localizations.localeOf(context);
    final fullUrl = WebViewScreen.buildUrl(url, locale);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WebViewScreen(title: title, url: fullUrl),
      ),
    );
  }

  Map<String, String> _getLevelNames(AppLocalizations l10n) {
    return {
      'a1': l10n.levelNameA1,
      'a2': l10n.levelNameA2,
      'b1': l10n.levelNameB1,
      'b2': l10n.levelNameB2,
      'c1': l10n.levelNameC1,
      'c2': l10n.levelNameC2,
    };
  }

  String _getThemeLabel(AppLocalizations l10n, String mode) {
    switch (mode) {
      case 'light':
        return l10n.themeLight;
      case 'dark':
        return l10n.themeDark;
      default:
        return l10n.themeSystem;
    }
  }

  String _getLanguageLabel(String localeValue) {
    final option = LanguageOption.fromValue(localeValue);
    return option.label;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final levelNames = _getLevelNames(l10n);

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.settings)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // 1. 학습
          _buildSectionHeader(context, l10n.study),
          ListTile(
            leading: Icon(Icons.flag, color: theme.colorScheme.primary),
            title: Text(l10n.levelTarget),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.getLevelColor(_targetLevel).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _targetLevel.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: AppColors.getLevelColor(_targetLevel),
                ),
              ),
            ),
            onTap: () => _showTargetLevelDialog(l10n, levelNames),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(l10n.dailyStudyAmount),
            trailing: Text(
              l10n.topicsUnit(_dailyGoal),
              style: theme.textTheme.bodyMedium,
            ),
            onTap: () => _showDailyGoalDialog(l10n),
          ),
          const Divider(height: 24),

          // 2. TTS 설정
          _buildSectionHeader(context, l10n.ttsSettings),
          SwitchListTile(
            secondary: const Icon(Icons.record_voice_over_outlined),
            title: Text(l10n.ttsAutoPlay),
            subtitle: Text(l10n.ttsAutoPlayDesc),
            value: _ttsAutoPlay,
            onChanged: (value) async {
              final dao = ref.read(userSettingsDaoProvider);
              await dao.setTtsAutoPlay(value);
              setState(() => _ttsAutoPlay = value);
            },
          ),
          ListTile(
            leading: const Icon(Icons.speed),
            title: Text(l10n.ttsSpeechRate),
            subtitle: Slider(
              value: _ttsSpeechRate,
              min: 0.2,
              max: 0.8,
              divisions: 6,
              label: _getSpeedLabel(l10n, _ttsSpeechRate),
              onChanged: (value) {
                setState(() => _ttsSpeechRate = value);
              },
              onChangeEnd: (value) async {
                final dao = ref.read(userSettingsDaoProvider);
                final ttsService = ref.read(ttsServiceProvider);
                await dao.setTtsSpeechRate(value);
                await ttsService.setSpeechRate(value);
                ref.invalidate(ttsSpeechRateProvider);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.play_circle_outline),
              tooltip: l10n.ttsTestPlay,
              onPressed: () {
                ref.read(ttsServiceProvider).speak('Hola, ¿cómo estás?');
              },
            ),
          ),
          if (_ttsVoices.isNotEmpty)
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(l10n.ttsVoice),
              trailing: Text(
                _ttsVoice ?? l10n.ttsVoiceDefault,
                style: theme.textTheme.bodyMedium,
              ),
              onTap: () => _showVoiceDialog(l10n),
            ),
          const Divider(height: 24),

          // 3. 알림
          _buildSectionHeader(context, l10n.notifications),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: Text(l10n.studyNotification),
            subtitle: Text(l10n.dailyNotification),
            value: _notificationEnabled,
            onChanged: (value) async {
              final dao = ref.read(userSettingsDaoProvider);
              final service = ref.read(notificationServiceProvider);

              if (value) {
                final granted = await service.requestPermission();
                if (!granted) return;
                await service.scheduleInactivityReminder();
              } else {
                await service.cancelReminder();
              }

              await dao.setNotificationEnabled(value);
              setState(() => _notificationEnabled = value);
            },
          ),
          const Divider(height: 24),

          // 4. 앱 설정
          _buildSectionHeader(context, l10n.appSettings),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            trailing: Text(
              _getLanguageLabel(_locale),
              style: theme.textTheme.bodyMedium,
            ),
            onTap: () => _showLanguageDialog(l10n),
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(l10n.theme),
            trailing: Text(
              _getThemeLabel(l10n, _themeMode),
              style: theme.textTheme.bodyMedium,
            ),
            onTap: () => _showThemeDialog(l10n),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.volume_up_outlined),
            title: Text(l10n.soundEffects),
            subtitle: Text(l10n.soundEffectsDesc),
            value: _soundEnabled,
            onChanged: (value) async {
              final dao = ref.read(userSettingsDaoProvider);
              await dao.setSoundEnabled(value);
              setState(() => _soundEnabled = value);
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.vibration),
            title: Text(l10n.vibration),
            subtitle: Text(l10n.vibrationDesc),
            value: _vibrationEnabled,
            onChanged: (value) async {
              final dao = ref.read(userSettingsDaoProvider);
              await dao.setVibrationEnabled(value);
              setState(() => _vibrationEnabled = value);
            },
          ),
          const Divider(height: 24),

          // 5. 프리미엄
          _buildSectionHeader(context, l10n.premium),
          _buildPremiumTile(l10n),
          const Divider(height: 24),

          // Data
          _buildSectionHeader(context, l10n.data),
          ListTile(
            leading: Icon(Icons.delete_outline, color: theme.colorScheme.error),
            title: Text(
              l10n.resetStudyRecords,
              style: TextStyle(color: theme.colorScheme.error),
            ),
            subtitle: Text(l10n.resetStudyRecordsDesc),
            onTap: () => _showResetDialog(l10n),
          ),
          const Divider(height: 24),

          // Info
          _buildSectionHeader(context, l10n.info),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.termsOfService),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openWebView(l10n.termsOfService, AppConfig.termsUrl),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l10n.privacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                _openWebView(l10n.privacyPolicy, AppConfig.privacyUrl),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: Text(l10n.support),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openWebView(l10n.support, AppConfig.supportUrl),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.appVersion),
            trailing: Text(
              AppConfig.fullVersion,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  String _getSpeedLabel(AppLocalizations l10n, double rate) {
    if (rate <= 0.3) return l10n.ttsSpeedSlow;
    if (rate >= 0.6) return l10n.ttsSpeedFast;
    return l10n.ttsSpeedNormal;
  }

  // ── Premium ──

  Widget _buildPremiumTile(AppLocalizations l10n) {
    final isPremium = ref.watch(isPremiumProvider);
    final product = ref.watch(removeAdsProductProvider);
    final isAvailable = ref.watch(isIAPAvailableProvider);

    if (isPremium) {
      return ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(l10n.removeAds),
        subtitle: Text(l10n.premiumActivated),
      );
    }

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.star, color: AppColors.secondary),
          title: Text(l10n.removeAds),
          subtitle: Text(
            isAvailable && product != null
                ? product.price
                : l10n.productNotAvailable,
          ),
          trailing: OutlinedButton(
            onPressed: isAvailable && product != null
                ? () => _purchaseRemoveAds(l10n)
                : null,
            child: Text(l10n.purchase),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.restore),
          title: Text(l10n.restorePurchases),
          onTap: () => _restorePurchases(l10n),
        ),
      ],
    );
  }

  Future<void> _purchaseRemoveAds(AppLocalizations l10n) async {
    final success = await IAPService().purchaseRemoveAds();
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.purchaseFailed)),
      );
    }
  }

  Future<void> _restorePurchases(AppLocalizations l10n) async {
    await IAPService().restorePurchases();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.purchasesRestored)),
      );
    }
  }

  // ── Dialogs ──

  Future<void> _showVoiceDialog(AppLocalizations l10n) async {
    final result = await showDialog<String?>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(l10n.ttsVoice),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, ''),
              child: Row(
                children: [
                  Text(l10n.ttsVoiceDefault),
                  if (_ttsVoice == null) ...[
                    const Spacer(),
                    const Icon(Icons.check, size: 20),
                  ],
                ],
              ),
            ),
            ..._ttsVoices.map((voice) {
              return SimpleDialogOption(
                onPressed: () => Navigator.pop(context, voice.name),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(voice.name),
                          Text(
                            voice.locale,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (voice.name == _ttsVoice)
                      const Icon(Icons.check, size: 20),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );

    if (result == null) return; // dialog dismissed

    final dao = ref.read(userSettingsDaoProvider);
    final ttsService = ref.read(ttsServiceProvider);

    if (result.isEmpty) {
      // "기본 음성" 선택
      await dao.setTtsVoice(null);
      await ttsService.setSpeechRate(_ttsSpeechRate);
      // 언어만 다시 설정하여 기본 음성 복원
      setState(() => _ttsVoice = null);
    } else {
      final voice = _ttsVoices.firstWhere((v) => v.name == result);
      await dao.setTtsVoice(result);
      await ttsService.setVoice(voice.name, voice.locale);
      setState(() => _ttsVoice = result);
    }
    ref.invalidate(ttsVoiceProvider);
  }

  Future<void> _showTargetLevelDialog(
    AppLocalizations l10n,
    Map<String, String> levelNames,
  ) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(l10n.selectTargetLevel),
          children: LevelConstants.levels.map((level) {
            final color = AppColors.getLevelColor(level);
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, level),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        level.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: color,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(levelNames[level] ?? level),
                  if (level == _targetLevel) ...[
                    const Spacer(),
                    const Icon(Icons.check, size: 20),
                  ],
                ],
              ),
            );
          }).toList(),
        );
      },
    );

    if (result != null && result != _targetLevel) {
      final dao = ref.read(userSettingsDaoProvider);
      await dao.setTargetLevel(result);
      setState(() => _targetLevel = result);
      ref.invalidate(appStatsProvider);
    }
  }

  Future<void> _showDailyGoalDialog(AppLocalizations l10n) async {
    final result = await showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(l10n.selectDailyGoal),
          children: DailyGoalOption.values.map((option) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, option.topicCount),
              child: Row(
                children: [
                  Text(l10n.topicsUnit(option.topicCount)),
                  if (option.topicCount == _dailyGoal) ...[
                    const Spacer(),
                    const Icon(Icons.check, size: 20),
                  ],
                ],
              ),
            );
          }).toList(),
        );
      },
    );

    if (result != null && result != _dailyGoal) {
      final dao = ref.read(userSettingsDaoProvider);
      await dao.setDailyGoal(result);
      setState(() => _dailyGoal = result);
      ref.invalidate(appStatsProvider);
    }
  }

  Future<void> _showLanguageDialog(AppLocalizations l10n) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(l10n.selectLanguage),
          children: LanguageOption.values.map((option) {
            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, option.value),
              child: Row(
                children: [
                  Text(option.label),
                  if (option.value == _locale) ...[
                    const Spacer(),
                    const Icon(Icons.check, size: 20),
                  ],
                ],
              ),
            );
          }).toList(),
        );
      },
    );

    if (result != null && result != _locale) {
      final dao = ref.read(userSettingsDaoProvider);
      await dao.setLocale(result);
      setState(() => _locale = result);
      ref.invalidate(appLocaleProvider);
      // Update content locale too
      final option = LanguageOption.fromValue(result);
      ref.read(currentLocaleProvider.notifier).state =
          option.localeCode ?? 'ko';
    }
  }

  Future<void> _showThemeDialog(AppLocalizations l10n) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(l10n.selectTheme),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'system'),
              child: Row(
                children: [
                  Text(l10n.themeSystem),
                  if (_themeMode == 'system') ...[
                    const Spacer(),
                    const Icon(Icons.check, size: 20),
                  ],
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'light'),
              child: Row(
                children: [
                  Text(l10n.themeLight),
                  if (_themeMode == 'light') ...[
                    const Spacer(),
                    const Icon(Icons.check, size: 20),
                  ],
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, 'dark'),
              child: Row(
                children: [
                  Text(l10n.themeDark),
                  if (_themeMode == 'dark') ...[
                    const Spacer(),
                    const Icon(Icons.check, size: 20),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );

    if (result != null && result != _themeMode) {
      final dao = ref.read(userSettingsDaoProvider);
      await dao.setThemeMode(result);
      setState(() => _themeMode = result);
      ref.invalidate(themeModeProvider);
    }
  }

  Future<void> _showResetDialog(AppLocalizations l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.resetStudyRecords),
          content: Text(l10n.resetStudyRecordsConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: Text(l10n.reset),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final studyRecordsDao = ref.read(studyRecordsDaoProvider);
      final wrongAnswersDao = ref.read(wrongAnswersDaoProvider);
      final dailyStatsDao = ref.read(dailyStatsDaoProvider);

      await Future.wait([
        studyRecordsDao.deleteAll(),
        wrongAnswersDao.deleteAll(),
        dailyStatsDao.deleteAll(),
      ]);

      ref.invalidate(appStatsProvider);
      ref.invalidate(wrongAnswersWithQuestionsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.studyRecordsReset)),
        );
      }
    }
  }
}
