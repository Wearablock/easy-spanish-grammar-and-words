import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/config/app_config.dart';
import '../../core/config/constants.dart';
import '../../core/config/setting_keys.dart';
import '../../core/theme/app_colors.dart';
import '../../data/providers/database_providers.dart';
import '../../data/providers/study_providers.dart';
import '../../data/providers/topic_providers.dart';
import '../../l10n/app_localizations.dart';

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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final dao = ref.read(userSettingsDaoProvider);
    final results = await Future.wait([
      dao.getTargetLevel(),
      dao.getDailyGoal(),
      dao.getNotificationEnabled(),
      dao.getLocale(),
      dao.getThemeMode(),
      dao.getSoundEnabled(),
      dao.getVibrationEnabled(),
      dao.getTtsAutoPlay(),
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
        _isLoading = false;
      });
    }
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.cannotOpenLink)),
      );
    }
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
          // Premium
          _buildSectionHeader(context, l10n.premium),
          ListTile(
            leading: const Icon(Icons.star, color: AppColors.secondary),
            title: Text(l10n.removeAds),
            trailing: OutlinedButton(
              onPressed: () {
                // TODO: IAP (Phase 6)
              },
              child: Text(l10n.purchase),
            ),
          ),
          const Divider(height: 24),

          // Target Level
          _buildSectionHeader(context, l10n.levelTarget),
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
          const Divider(height: 24),

          // Study
          _buildSectionHeader(context, l10n.study),
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

          // Notifications
          _buildSectionHeader(context, l10n.notifications),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: Text(l10n.studyNotification),
            subtitle: Text(l10n.dailyNotification),
            value: _notificationEnabled,
            onChanged: (value) async {
              final dao = ref.read(userSettingsDaoProvider);
              await dao.setNotificationEnabled(value);
              setState(() => _notificationEnabled = value);
            },
          ),
          const Divider(height: 24),

          // App Settings
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
            onTap: () => _openUrl(AppConfig.termsUrl),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l10n.privacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openUrl(AppConfig.privacyUrl),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: Text(l10n.support),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openUrl(AppConfig.supportUrl),
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

  // ── Dialogs ──

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
