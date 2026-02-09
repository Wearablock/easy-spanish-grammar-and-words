import 'package:flutter/material.dart';

import '../../core/config/app_config.dart';
import '../../core/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // 프리미엄
          _buildSectionHeader(context, l10n.premium),
          ListTile(
            leading:
                const Icon(Icons.star, color: AppColors.secondary),
            title: Text(l10n.removeAds),
            trailing: OutlinedButton(
              onPressed: () {
                // TODO: IAP
              },
              child: Text(l10n.purchase),
            ),
          ),
          const Divider(height: 24),

          // 목표 레벨 설정
          _buildSectionHeader(context, l10n.levelTarget),
          ListTile(
            leading: Icon(Icons.flag, color: theme.colorScheme.primary),
            title: Text(l10n.levelTarget),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.levelB1.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'B1',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: AppColors.levelB1,
                ),
              ),
            ),
          ),
          const Divider(height: 24),

          // 학습 설정
          _buildSectionHeader(context, l10n.study),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: Text(l10n.dailyStudyAmount),
            trailing: Text(
              l10n.topicsUnit(2),
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const Divider(height: 24),

          // 알림
          _buildSectionHeader(context, l10n.notifications),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: Text(l10n.studyNotification),
            subtitle: Text(l10n.dailyNotification),
            value: false,
            onChanged: (value) {
              // TODO: 알림 설정
            },
          ),
          const Divider(height: 24),

          // 앱 설정
          _buildSectionHeader(context, l10n.appSettings),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            trailing: Text(
              l10n.languageSystem,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(l10n.theme),
            trailing: Text(
              l10n.themeSystem,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.volume_up_outlined),
            title: Text(l10n.soundEffects),
            subtitle: Text(l10n.soundEffectsDesc),
            value: true,
            onChanged: (value) {
              // TODO: 사운드 설정
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.vibration),
            title: Text(l10n.vibration),
            subtitle: Text(l10n.vibrationDesc),
            value: true,
            onChanged: (value) {
              // TODO: 진동 설정
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.record_voice_over_outlined),
            title: Text(l10n.ttsAutoPlay),
            subtitle: Text(l10n.ttsAutoPlayDesc),
            value: false,
            onChanged: (value) {
              // TODO: TTS 설정
            },
          ),
          const Divider(height: 24),

          // 정보
          _buildSectionHeader(context, l10n.info),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.termsOfService),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 이용약관
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l10n.privacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 개인정보처리방침
            },
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: Text(l10n.support),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 고객 지원
            },
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
}
