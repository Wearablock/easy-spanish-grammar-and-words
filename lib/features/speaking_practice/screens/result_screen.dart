import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../data/speaking_models.dart';
import '../utils/speaking_palette.dart';
import '../utils/text_similarity.dart';

class _ResultItem extends StatelessWidget {
  final AttemptResult r;
  final String locale;
  const _ResultItem({required this.r, required this.locale});

  @override
  Widget build(BuildContext context) {
    final accent = SpeakingPalette.accuracyAccent(r.accuracy);
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: accent.withValues(alpha: 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: accent.withValues(alpha: 0.2), width: 0.8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: accent.withValues(alpha: 0.18),
          child: Icon(
            TextSimilarity.isPass(r.accuracy) ? Icons.check : Icons.close,
            color: accent,
          ),
        ),
        title: Text(r.card.es,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              r.card.translationFor(locale),
              style: TextStyle(
                fontSize: 12,
                color: cs.onSurface.withValues(alpha: 0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 2),
            Text('→ ${r.spoken}',
                style: TextStyle(
                    fontSize: 12, color: cs.onSurface.withValues(alpha: 0.85))),
          ],
        ),
        trailing: Text(
          TextSimilarity.toPercent(r.accuracy),
          style: TextStyle(color: accent, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// 연습/테스트 종료 화면 — 카드별 결과와 합산.
class SpeakingResultScreen extends StatelessWidget {
  final String seedTitle;
  final List<AttemptResult> results;
  final bool isTestMode;

  const SpeakingResultScreen({
    super.key,
    required this.seedTitle,
    required this.results,
    required this.isTestMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final passedCount =
        results.where((r) => TextSimilarity.isPass(r.accuracy)).length;
    final total = results.length;
    final avg = total == 0
        ? 0.0
        : results.map((r) => r.accuracy).reduce((a, b) => a + b) / total;
    final passRate = total == 0 ? 0.0 : passedCount / total;
    final isTestPass = isTestMode && passRate >= 0.7;
    final summaryAccent = SpeakingPalette.accuracyAccent(avg);

    return Scaffold(
      appBar: AppBar(
        title: Text(isTestMode ? l10n.testResult : l10n.practiceResult),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(
                    seedTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: SpeakingPalette.accuracyDecoration(avg),
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      children: [
                        if (isTestMode)
                          Icon(
                            isTestPass ? Icons.emoji_events : Icons.refresh,
                            size: 56,
                            color: SpeakingPalette.resultIcon(isTestPass),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.passedOfTotal(passedCount, total),
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: summaryAccent,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.averageAccuracy(
                              TextSimilarity.toPercent(avg)),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.75),
                          ),
                        ),
                        if (isTestMode) ...[
                          const SizedBox(height: 8),
                          Text(
                            isTestPass ? l10n.testPassed : l10n.testFailed,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isTestPass
                                  ? AppColors.correct
                                  : AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...results.map((r) => _ResultItem(r: r, locale: locale)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context)
                      .popUntil((route) => route.isFirst),
                  child: Text(l10n.goHome),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
