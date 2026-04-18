import '../../../l10n/app_localizations.dart';
import '../data/speaking_models.dart';

/// 변형 카드 종류 → l10n 라벨 변환.
String variationLabel(AppLocalizations l10n, SpeakingCard card) {
  switch (card.kind) {
    case VariationKind.base:
      return l10n.variationBase;
    case VariationKind.subject:
      return l10n.variationSubject(card.subjectArg ?? '');
    case VariationKind.negative:
      return l10n.variationNegative;
    case VariationKind.interrogative:
      return l10n.variationInterrogative;
    case VariationKind.nounSwap:
      return l10n.variationNounSwap(card.nounArg ?? '');
    case VariationKind.phrase:
      return l10n.variationPhrase;
  }
}

/// 정확도(0~1) → l10n 피드백 텍스트.
String accuracyFeedback(AppLocalizations l10n, double accuracy) {
  if (accuracy >= 0.95) return l10n.feedbackPerfect;
  if (accuracy >= 0.8) return l10n.feedbackGreat;
  if (accuracy >= 0.6) return l10n.feedbackGood;
  if (accuracy >= 0.4) return l10n.feedbackKeepPractice;
  return l10n.feedbackTryAgain;
}
