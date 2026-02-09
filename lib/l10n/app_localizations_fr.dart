// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Espagnol Facile';

  @override
  String get appFullTitle => 'Espagnol Facile - Grammaire';

  @override
  String get home => 'Accueil';

  @override
  String get progress => 'Progrès';

  @override
  String get settings => 'Paramètres';

  @override
  String get wrongAnswers => 'Erreurs';

  @override
  String error(String message) {
    return 'Erreur : $message';
  }

  @override
  String get startStudy => 'Commencer l\'étude';

  @override
  String get continueStudy => 'Continuer l\'étude';

  @override
  String get startReview => 'Réviser';

  @override
  String get todayStudy => 'Étude du jour';

  @override
  String get allTopicsCompleted => 'Tous les sujets terminés !';

  @override
  String get reviewEncouragement =>
      'Continuez à réviser pour maîtriser le contenu.';

  @override
  String get nextTopic => 'Sujet suivant';

  @override
  String questionsCount(int count) {
    return '$count questions';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '$count questions terminées aujourd\'hui';
  }

  @override
  String get todayGoal => 'Objectif du jour';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal sujets';
  }

  @override
  String streakDays(int days) {
    return '$days jours consécutifs !';
  }

  @override
  String get overallProgress => 'Progrès global';

  @override
  String get mastered => 'Maîtrisé';

  @override
  String get studiedOnce => 'Étudié au moins une fois';

  @override
  String totalQuestions(int count) {
    return '$count questions au total';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total questions maîtrisées';
  }

  @override
  String get study => 'Étude';

  @override
  String get notifications => 'Notifications';

  @override
  String get appSettings => 'Paramètres de l\'app';

  @override
  String get info => 'Informations';

  @override
  String get appVersion => 'Version de l\'app';

  @override
  String get termsAndPolicies => 'Conditions et politiques';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get support => 'Support';

  @override
  String get data => 'Données';

  @override
  String get resetStudyRecords => 'Réinitialiser les données';

  @override
  String get resetStudyRecordsDesc =>
      'Supprimer tous les enregistrements d\'étude';

  @override
  String get resetStudyRecordsConfirm =>
      'Tous les enregistrements d\'étude seront supprimés.\nCette action est irréversible.';

  @override
  String get cannotOpenLink => 'Impossible d\'ouvrir le lien.';

  @override
  String get cancel => 'Annuler';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get confirm => 'Confirmer';

  @override
  String get studyRecordsReset =>
      'Les enregistrements d\'étude ont été réinitialisés.';

  @override
  String get dailyStudyAmount => 'Quantité d\'étude quotidienne';

  @override
  String topicsUnit(int count) {
    return '$count sujets';
  }

  @override
  String get customSetting => 'Personnalisé';

  @override
  String get theme => 'Thème';

  @override
  String get selectTheme => 'Choisir le thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Mode clair';

  @override
  String get themeDark => 'Mode sombre';

  @override
  String get studyComplete => 'Étude terminée';

  @override
  String get goodJob => 'Bon travail !';

  @override
  String get goHome => 'Retour à l\'accueil';

  @override
  String get accuracy => 'Précision';

  @override
  String get correct => 'Correct';

  @override
  String get wrong => 'Incorrect';

  @override
  String get timeSpent => 'Temps passé';

  @override
  String get wrongReview => 'Révision des erreurs';

  @override
  String get spacedReview => 'Révision espacée';

  @override
  String get newLearning => 'Nouvel apprentissage';

  @override
  String get errorOccurred => 'Une erreur est survenue';

  @override
  String get retry => 'Réessayer';

  @override
  String get stopStudy => 'Arrêter l\'étude';

  @override
  String get stopStudyConfirm =>
      'Voulez-vous arrêter l\'étude ?\nVotre progrès sera sauvegardé.';

  @override
  String get continueStudyButton => 'Continuer';

  @override
  String get stop => 'Arrêter';

  @override
  String get levelProgress => 'Progrès par niveau';

  @override
  String get reviewAvailable => 'Vous avez des questions à réviser !';

  @override
  String reviewWaiting(int count) {
    return '$count questions en attente de révision';
  }

  @override
  String get welcome => 'Bienvenue !';

  @override
  String get selectLevel => 'Sélectionnez votre niveau cible';

  @override
  String get canChangeInSettings =>
      'Vous pourrez le modifier dans les paramètres';

  @override
  String get start => 'Commencer';

  @override
  String get levelTarget => 'Niveau cible';

  @override
  String get levelNameA1 => 'Débutant';

  @override
  String get levelNameA2 => 'Élémentaire';

  @override
  String get levelNameB1 => 'Intermédiaire';

  @override
  String get levelNameB2 => 'Intermédiaire avancé';

  @override
  String get levelNameC1 => 'Avancé';

  @override
  String get levelNameC2 => 'Maîtrise';

  @override
  String get grammar => 'Grammaire';

  @override
  String get vocabulary => 'Vocabulaire';

  @override
  String get grammarAndVocabulary => 'Grammaire & Vocabulaire';

  @override
  String get noWrongAnswers => 'Aucune erreur !';

  @override
  String get noWrongAnswersDesc =>
      'Vous vous en sortez très bien !\nContinuez comme ça !';

  @override
  String wrongCount(int count) {
    return '$count fois incorrect';
  }

  @override
  String get correctAnswer => 'Bonne réponse';

  @override
  String get yourAnswer => 'Votre réponse';

  @override
  String get explanation => 'Explication';

  @override
  String get premium => 'Premium';

  @override
  String get removeAds => 'Supprimer les pubs';

  @override
  String get premiumActivated => 'Premium activé';

  @override
  String get purchase => 'Acheter';

  @override
  String get restorePurchases => 'Restaurer les achats';

  @override
  String get studyNotification => 'Rappel d\'étude';

  @override
  String get dailyNotification => 'Rappel quotidien à l\'heure fixée';

  @override
  String get notificationOff => 'Notifications désactivées';

  @override
  String get notificationTime => 'Heure de notification';

  @override
  String get notificationChannelName => 'Rappel d\'étude';

  @override
  String get notificationChannelDesc => 'Rappels quotidiens d\'étude';

  @override
  String get notificationTitle => 'Espagnol Facile';

  @override
  String get notificationBody => 'C\'est l\'heure de commencer à étudier !';

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Choisir la langue';

  @override
  String get languageSystem => 'Système';

  @override
  String get soundAndVibration => 'Son et vibration';

  @override
  String get soundEffects => 'Effets sonores';

  @override
  String get soundEffectsDesc =>
      'Jouer un son en cas de bonne/mauvaise réponse';

  @override
  String get vibration => 'Vibration';

  @override
  String get vibrationDesc => 'Vibration en cas de bonne/mauvaise réponse';

  @override
  String get ttsSettings => 'Paramètres TTS';

  @override
  String get ttsAutoPlay => 'Lecture automatique';

  @override
  String get ttsAutoPlayDesc =>
      'Prononcer l\'espagnol automatiquement en cas de bonne réponse';
}
