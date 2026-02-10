import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../services/study_service.dart';

class StudyCtaButton extends StatelessWidget {
  final TodaySummary summary;
  final VoidCallback onPressed;

  const StudyCtaButton({
    super.key,
    required this.summary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final String label;
    final IconData icon;

    if (summary.allTopicsCompleted) {
      label = l10n.startReview;
      icon = Icons.replay;
    } else if (summary.isTodayGoalAchieved) {
      label = l10n.continueStudy;
      icon = Icons.play_arrow;
    } else {
      label = l10n.startStudy;
      icon = Icons.play_arrow;
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }
}
