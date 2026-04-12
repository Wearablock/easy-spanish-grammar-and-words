import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// 마이크/음성 인식 권한 거부 시 표시되는 다이얼로그.
///
/// "설정 열기" 버튼은 OS 설정 앱을 열어 사용자가 권한을 직접 부여할 수 있게 한다.
class PermissionDeniedDialog extends StatelessWidget {
  const PermissionDeniedDialog({super.key});

  /// 편의 호출 — 호출 측에서 `showDialog()` 직접 호출 대신 사용.
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const PermissionDeniedDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      icon: const Icon(Icons.mic_off, size: 36),
      title: Text(l10n.speakingPractice),
      content: Text(l10n.micPermissionRequired),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton.icon(
          onPressed: () async {
            Navigator.pop(context);
            await AppSettings.openAppSettings();
          },
          icon: const Icon(Icons.settings, size: 18),
          label: Text(l10n.openSettings),
        ),
      ],
    );
  }
}
