// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Easy Spanish';

  @override
  String get appFullTitle => 'Easy Spanish - Grammar & Words';

  @override
  String get home => 'Home';

  @override
  String get progress => 'Progress';

  @override
  String get settings => 'Settings';

  @override
  String get wrongAnswers => 'Wrong Answers';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get startStudy => 'Start Study';

  @override
  String get continueStudy => 'Continue Study';

  @override
  String get startReview => 'Start Review';

  @override
  String get todayStudy => 'Today\'s Study';

  @override
  String get allTopicsCompleted => 'All Topics Completed!';

  @override
  String get reviewEncouragement =>
      'Keep practicing with reviews to master the content.';

  @override
  String get nextTopic => 'Next Topic';

  @override
  String questionsCount(int count) {
    return '$count questions';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '$count questions completed today';
  }

  @override
  String get todayGoal => 'Today\'s Goal';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal topics';
  }

  @override
  String streakDays(int days) {
    return '$days day streak!';
  }

  @override
  String get overallProgress => 'Overall Progress';

  @override
  String get mastered => 'Mastered';

  @override
  String get studiedOnce => 'Studied Once';

  @override
  String totalQuestions(int count) {
    return 'Total $count questions';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total questions mastered';
  }

  @override
  String get study => 'Study';

  @override
  String get notifications => 'Notifications';

  @override
  String get appSettings => 'App Settings';

  @override
  String get info => 'Info';

  @override
  String get appVersion => 'App Version';

  @override
  String get termsAndPolicies => 'Terms & Policies';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get support => 'Support';

  @override
  String get data => 'Data';

  @override
  String get resetStudyRecords => 'Reset Study Records';

  @override
  String get resetStudyRecordsDesc => 'Delete all study records';

  @override
  String get resetStudyRecordsConfirm =>
      'All study records will be deleted.\nThis action cannot be undone.';

  @override
  String get cannotOpenLink => 'Cannot open link.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get confirm => 'Confirm';

  @override
  String get studyRecordsReset => 'Study records have been reset.';

  @override
  String get dailyStudyAmount => 'Daily Study Amount';

  @override
  String topicsUnit(int count) {
    return '$count topics';
  }

  @override
  String get customSetting => 'Custom';

  @override
  String get theme => 'Theme';

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get themeSystem => 'System Default';

  @override
  String get themeLight => 'Light Mode';

  @override
  String get themeDark => 'Dark Mode';

  @override
  String get studyComplete => 'Study Complete';

  @override
  String get goodJob => 'Good job!';

  @override
  String get goHome => 'Go Home';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get correct => 'Correct';

  @override
  String get wrong => 'Wrong';

  @override
  String get timeSpent => 'Time Spent';

  @override
  String get wrongReview => 'Wrong Review';

  @override
  String get spacedReview => 'Spaced Review';

  @override
  String get newLearning => 'New Learning';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get retry => 'Retry';

  @override
  String get stopStudy => 'Stop Study';

  @override
  String get stopStudyConfirm =>
      'Do you want to stop studying?\nYour progress will be saved.';

  @override
  String get continueStudyButton => 'Continue';

  @override
  String get stop => 'Stop';

  @override
  String get levelProgress => 'Progress by Level';

  @override
  String get reviewAvailable => 'You have questions to review!';

  @override
  String reviewWaiting(int count) {
    return '$count questions waiting for review';
  }

  @override
  String get welcome => 'Welcome!';

  @override
  String get selectLevel => 'Select your target level';

  @override
  String get canChangeInSettings => 'You can change this in settings later';

  @override
  String get start => 'Start';

  @override
  String get levelTarget => 'Target Level';

  @override
  String get levelNameA1 => 'Beginner';

  @override
  String get levelNameA2 => 'Elementary';

  @override
  String get levelNameB1 => 'Intermediate';

  @override
  String get levelNameB2 => 'Upper Intermediate';

  @override
  String get levelNameC1 => 'Advanced';

  @override
  String get levelNameC2 => 'Mastery';

  @override
  String get grammar => 'Grammar';

  @override
  String get vocabulary => 'Vocabulary';

  @override
  String get grammarAndVocabulary => 'Grammar & Vocabulary';

  @override
  String get noWrongAnswers => 'No wrong answers!';

  @override
  String get noWrongAnswersDesc =>
      'You\'re doing great! Keep up the good work\nand continue building your skills!';

  @override
  String wrongCount(int count) {
    return 'Wrong $count times';
  }

  @override
  String get correctAnswer => 'Correct Answer';

  @override
  String get yourAnswer => 'Your Answer';

  @override
  String get explanation => 'Explanation';

  @override
  String get premium => 'Premium';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get premiumActivated => 'Premium activated';

  @override
  String get purchase => 'Purchase';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get studyNotification => 'Study Notification';

  @override
  String get dailyNotification => 'Daily reminder at set time';

  @override
  String get notificationOff => 'Notification off';

  @override
  String get notificationTime => 'Notification Time';

  @override
  String get notificationChannelName => 'Study Reminder';

  @override
  String get notificationChannelDesc => 'Daily study time reminders';

  @override
  String get notificationTitle => 'Easy Spanish';

  @override
  String get notificationBody => 'Time to start today\'s study!';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get languageSystem => 'System Default';

  @override
  String get soundAndVibration => 'Sound & Vibration';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get soundEffectsDesc => 'Play sound on correct/wrong answers';

  @override
  String get vibration => 'Vibration';

  @override
  String get vibrationDesc => 'Haptic feedback on correct/wrong answers';

  @override
  String get ttsSettings => 'TTS Settings';

  @override
  String get ttsAutoPlay => 'Auto Play';

  @override
  String get ttsAutoPlayDesc => 'Auto-pronounce Spanish on correct answer';

  @override
  String get showHint => 'Show Hint';

  @override
  String get nextQuestion => 'Next Question';

  @override
  String get keyPoints => 'Key Points';

  @override
  String get theoryComplete => 'Complete';

  @override
  String get excellentComplete => 'Excellent!';

  @override
  String get goodComplete => 'Good Job!';

  @override
  String get phaseResults => 'Phase Results';

  @override
  String get additionalStudy => 'Study More';

  @override
  String continueReviewWithCount(int count) {
    return 'Continue Review ($count remaining)';
  }
}
