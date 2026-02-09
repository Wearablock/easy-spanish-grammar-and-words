// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Spanisch Leicht';

  @override
  String get appFullTitle => 'Spanisch Leicht - Grammatik';

  @override
  String get home => 'Start';

  @override
  String get progress => 'Fortschritt';

  @override
  String get settings => 'Einstellungen';

  @override
  String get wrongAnswers => 'Fehlerliste';

  @override
  String error(String message) {
    return 'Fehler: $message';
  }

  @override
  String get startStudy => 'Lernen starten';

  @override
  String get continueStudy => 'Lernen fortsetzen';

  @override
  String get startReview => 'Wiederholen';

  @override
  String get todayStudy => 'Heutiges Lernen';

  @override
  String get allTopicsCompleted => 'Alle Themen abgeschlossen!';

  @override
  String get reviewEncouragement =>
      'Wiederhole weiter, um den Stoff zu meistern.';

  @override
  String get nextTopic => 'Nächstes Thema';

  @override
  String questionsCount(int count) {
    return '$count Fragen';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '$count Fragen heute erledigt';
  }

  @override
  String get todayGoal => 'Heutiges Ziel';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal Themen';
  }

  @override
  String streakDays(int days) {
    return '$days Tage in Folge!';
  }

  @override
  String get overallProgress => 'Gesamtfortschritt';

  @override
  String get mastered => 'Gemeistert';

  @override
  String get studiedOnce => 'Mindestens einmal gelernt';

  @override
  String totalQuestions(int count) {
    return 'Insgesamt $count Fragen';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total Fragen gemeistert';
  }

  @override
  String get study => 'Lernen';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get appSettings => 'App-Einstellungen';

  @override
  String get info => 'Info';

  @override
  String get appVersion => 'App-Version';

  @override
  String get termsAndPolicies => 'Bedingungen & Richtlinien';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get support => 'Support';

  @override
  String get data => 'Daten';

  @override
  String get resetStudyRecords => 'Lernaufzeichnungen zurücksetzen';

  @override
  String get resetStudyRecordsDesc => 'Alle Lernaufzeichnungen löschen';

  @override
  String get resetStudyRecordsConfirm =>
      'Alle Lernaufzeichnungen werden gelöscht.\nDiese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get cannotOpenLink => 'Link kann nicht geöffnet werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get studyRecordsReset => 'Lernaufzeichnungen wurden zurückgesetzt.';

  @override
  String get dailyStudyAmount => 'Tägliche Lernmenge';

  @override
  String topicsUnit(int count) {
    return '$count Themen';
  }

  @override
  String get customSetting => 'Benutzerdefiniert';

  @override
  String get theme => 'Design';

  @override
  String get selectTheme => 'Design wählen';

  @override
  String get themeSystem => 'Systemstandard';

  @override
  String get themeLight => 'Heller Modus';

  @override
  String get themeDark => 'Dunkler Modus';

  @override
  String get studyComplete => 'Lernen abgeschlossen';

  @override
  String get goodJob => 'Gut gemacht!';

  @override
  String get goHome => 'Zur Startseite';

  @override
  String get accuracy => 'Genauigkeit';

  @override
  String get correct => 'Richtig';

  @override
  String get wrong => 'Falsch';

  @override
  String get timeSpent => 'Zeitaufwand';

  @override
  String get wrongReview => 'Fehlerwiederholung';

  @override
  String get spacedReview => 'Verteilte Wiederholung';

  @override
  String get newLearning => 'Neues Lernen';

  @override
  String get errorOccurred => 'Ein Fehler ist aufgetreten';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get stopStudy => 'Lernen stoppen';

  @override
  String get stopStudyConfirm =>
      'Möchtest du das Lernen stoppen?\nDein Fortschritt wird gespeichert.';

  @override
  String get continueStudyButton => 'Weiterlernen';

  @override
  String get stop => 'Stoppen';

  @override
  String get levelProgress => 'Fortschritt nach Stufe';

  @override
  String get reviewAvailable => 'Du hast Fragen zum Wiederholen!';

  @override
  String reviewWaiting(int count) {
    return '$count Fragen warten auf Wiederholung';
  }

  @override
  String get welcome => 'Willkommen!';

  @override
  String get selectLevel => 'Wähle dein Zielniveau';

  @override
  String get canChangeInSettings =>
      'Du kannst es später in den Einstellungen ändern';

  @override
  String get start => 'Starten';

  @override
  String get levelTarget => 'Zielniveau';

  @override
  String get levelNameA1 => 'Anfänger';

  @override
  String get levelNameA2 => 'Grundstufe';

  @override
  String get levelNameB1 => 'Mittelstufe';

  @override
  String get levelNameB2 => 'Obere Mittelstufe';

  @override
  String get levelNameC1 => 'Fortgeschritten';

  @override
  String get levelNameC2 => 'Meisterniveau';

  @override
  String get grammar => 'Grammatik';

  @override
  String get vocabulary => 'Wortschatz';

  @override
  String get grammarAndVocabulary => 'Grammatik & Wortschatz';

  @override
  String get noWrongAnswers => 'Keine Fehler!';

  @override
  String get noWrongAnswersDesc => 'Du machst das großartig!\nWeiter so!';

  @override
  String wrongCount(int count) {
    return '$count Mal falsch';
  }

  @override
  String get correctAnswer => 'Richtige Antwort';

  @override
  String get yourAnswer => 'Deine Antwort';

  @override
  String get explanation => 'Erklärung';

  @override
  String get premium => 'Premium';

  @override
  String get removeAds => 'Werbung entfernen';

  @override
  String get premiumActivated => 'Premium aktiviert';

  @override
  String get purchase => 'Kaufen';

  @override
  String get restorePurchases => 'Käufe wiederherstellen';

  @override
  String get studyNotification => 'Lernerinnerung';

  @override
  String get dailyNotification => 'Tägliche Erinnerung zur festgelegten Zeit';

  @override
  String get notificationOff => 'Benachrichtigungen aus';

  @override
  String get notificationTime => 'Benachrichtigungszeit';

  @override
  String get notificationChannelName => 'Lernerinnerung';

  @override
  String get notificationChannelDesc => 'Tägliche Lernerinnerungen';

  @override
  String get notificationTitle => 'Spanisch Leicht';

  @override
  String get notificationBody => 'Zeit, mit dem Lernen zu beginnen!';

  @override
  String get language => 'Sprache';

  @override
  String get selectLanguage => 'Sprache wählen';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get soundAndVibration => 'Ton & Vibration';

  @override
  String get soundEffects => 'Soundeffekte';

  @override
  String get soundEffectsDesc => 'Ton bei richtiger/falscher Antwort abspielen';

  @override
  String get vibration => 'Vibration';

  @override
  String get vibrationDesc => 'Vibration bei richtiger/falscher Antwort';

  @override
  String get ttsSettings => 'TTS-Einstellungen';

  @override
  String get ttsAutoPlay => 'Automatische Wiedergabe';

  @override
  String get ttsAutoPlayDesc =>
      'Spanisch automatisch aussprechen bei richtiger Antwort';
}
