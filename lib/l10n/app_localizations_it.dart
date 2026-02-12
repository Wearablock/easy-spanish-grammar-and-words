// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Spagnolo Facile';

  @override
  String get appFullTitle => 'Spagnolo Facile - Grammatica';

  @override
  String get home => 'Home';

  @override
  String get progress => 'Progresso';

  @override
  String get settings => 'Impostazioni';

  @override
  String get wrongAnswers => 'Errori';

  @override
  String error(String message) {
    return 'Errore: $message';
  }

  @override
  String get startStudy => 'Inizia a studiare';

  @override
  String get continueStudy => 'Continua a studiare';

  @override
  String get startReview => 'Ripassa';

  @override
  String get todayStudy => 'Studio di oggi';

  @override
  String get allTopicsCompleted => 'Tutti gli argomenti completati!';

  @override
  String get reviewEncouragement =>
      'Continua a ripassare per padroneggiare i contenuti.';

  @override
  String get nextTopic => 'Argomento successivo';

  @override
  String questionsCount(int count) {
    return '$count domande';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '$count domande completate oggi';
  }

  @override
  String get todayGoal => 'Obiettivo di oggi';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal argomenti';
  }

  @override
  String streakDays(int days) {
    return '$days giorni consecutivi!';
  }

  @override
  String get overallProgress => 'Progresso generale';

  @override
  String get mastered => 'Padroneggiato';

  @override
  String get studiedOnce => 'Studiato almeno una volta';

  @override
  String totalQuestions(int count) {
    return '$count domande in totale';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total domande padroneggiate';
  }

  @override
  String get study => 'Studio';

  @override
  String get notifications => 'Notifiche';

  @override
  String get appSettings => 'Impostazioni app';

  @override
  String get info => 'Informazioni';

  @override
  String get appVersion => 'Versione app';

  @override
  String get termsAndPolicies => 'Termini e condizioni';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get support => 'Supporto';

  @override
  String get data => 'Dati';

  @override
  String get resetStudyRecords => 'Reimposta i dati';

  @override
  String get resetStudyRecordsDesc => 'Elimina tutti i dati di studio';

  @override
  String get resetStudyRecordsConfirm =>
      'Tutti i dati di studio verranno eliminati.\nQuesta azione non può essere annullata.';

  @override
  String get cannotOpenLink => 'Impossibile aprire il link.';

  @override
  String get cancel => 'Annulla';

  @override
  String get reset => 'Reimposta';

  @override
  String get confirm => 'Conferma';

  @override
  String get studyRecordsReset => 'I dati di studio sono stati reimpostati.';

  @override
  String get dailyStudyAmount => 'Quantità di studio giornaliera';

  @override
  String topicsUnit(int count) {
    return '$count argomenti';
  }

  @override
  String get customSetting => 'Personalizzato';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Seleziona tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Modalità chiara';

  @override
  String get themeDark => 'Modalità scura';

  @override
  String get studyComplete => 'Studio completato';

  @override
  String get goodJob => 'Ottimo lavoro!';

  @override
  String get goHome => 'Vai alla home';

  @override
  String get accuracy => 'Precisione';

  @override
  String get correct => 'Corretto';

  @override
  String get wrong => 'Sbagliato';

  @override
  String get timeSpent => 'Tempo impiegato';

  @override
  String get wrongReview => 'Ripasso errori';

  @override
  String get spacedReview => 'Ripasso spaziato';

  @override
  String get newLearning => 'Nuovo apprendimento';

  @override
  String get errorOccurred => 'Si è verificato un errore';

  @override
  String get retry => 'Riprova';

  @override
  String get stopStudy => 'Interrompi studio';

  @override
  String get stopStudyConfirm =>
      'Vuoi interrompere lo studio?\nI tuoi progressi verranno salvati.';

  @override
  String get continueStudyButton => 'Continua';

  @override
  String get stop => 'Interrompi';

  @override
  String get levelProgress => 'Progresso per livello';

  @override
  String get reviewAvailable => 'Hai domande da ripassare!';

  @override
  String reviewWaiting(int count) {
    return '$count domande in attesa di ripasso';
  }

  @override
  String get welcome => 'Benvenuto!';

  @override
  String get selectLevel => 'Seleziona il tuo livello obiettivo';

  @override
  String get canChangeInSettings => 'Puoi modificarlo nelle impostazioni';

  @override
  String get start => 'Inizia';

  @override
  String get levelTarget => 'Livello obiettivo';

  @override
  String get levelNameA1 => 'Principiante';

  @override
  String get levelNameA2 => 'Elementare';

  @override
  String get levelNameB1 => 'Intermedio';

  @override
  String get levelNameB2 => 'Intermedio superiore';

  @override
  String get levelNameC1 => 'Avanzato';

  @override
  String get levelNameC2 => 'Padronanza';

  @override
  String get grammar => 'Grammatica';

  @override
  String get vocabulary => 'Vocabolario';

  @override
  String get grammarAndVocabulary => 'Grammatica & Vocabolario';

  @override
  String get noWrongAnswers => 'Nessun errore!';

  @override
  String get noWrongAnswersDesc => 'Stai andando alla grande!\nContinua così!';

  @override
  String wrongCount(int count) {
    return 'Sbagliato $count volte';
  }

  @override
  String get correctAnswer => 'Risposta corretta';

  @override
  String get yourAnswer => 'La tua risposta';

  @override
  String get explanation => 'Spiegazione';

  @override
  String get premium => 'Premium';

  @override
  String get removeAds => 'Rimuovi pubblicità';

  @override
  String get premiumActivated => 'Premium attivato';

  @override
  String get purchase => 'Acquista';

  @override
  String get restorePurchases => 'Ripristina acquisti';

  @override
  String get purchaseFailed => 'Acquisto fallito';

  @override
  String get purchasesRestored => 'Acquisti ripristinati';

  @override
  String get productNotAvailable => 'Prodotto non disponibile';

  @override
  String get studyNotification => 'Promemoria studio';

  @override
  String get dailyNotification =>
      'Promemoria di studio dopo più di un giorno di inattività';

  @override
  String get notificationOff => 'Notifiche disattivate';

  @override
  String get notificationTime => 'Orario notifica';

  @override
  String get notificationChannelName => 'Promemoria studio';

  @override
  String get notificationChannelDesc => 'Promemoria giornalieri di studio';

  @override
  String get notificationTitle => 'Spagnolo Facile';

  @override
  String get notificationBody => 'È ora di iniziare a studiare!';

  @override
  String get language => 'Lingua';

  @override
  String get selectLanguage => 'Seleziona lingua';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get soundAndVibration => 'Suono e vibrazione';

  @override
  String get soundEffects => 'Effetti sonori';

  @override
  String get soundEffectsDesc => 'Suono alla risposta corretta/sbagliata';

  @override
  String get vibration => 'Vibrazione';

  @override
  String get vibrationDesc => 'Vibrazione alla risposta corretta/sbagliata';

  @override
  String get ttsSettings => 'Impostazioni voce';

  @override
  String get ttsAutoPlay => 'Riproduzione automatica';

  @override
  String get ttsAutoPlayDesc =>
      'Pronuncia spagnolo automaticamente alla risposta corretta';

  @override
  String get ttsSpeechRate => 'Velocità';

  @override
  String get ttsVoice => 'Voce';

  @override
  String get ttsVoiceDefault => 'Predefinita';

  @override
  String get ttsSpeedSlow => 'Lento';

  @override
  String get ttsSpeedNormal => 'Normale';

  @override
  String get ttsSpeedFast => 'Veloce';

  @override
  String get ttsTestPlay => 'Anteprima';

  @override
  String get showHint => 'Mostra suggerimento';

  @override
  String get nextQuestion => 'Prossima domanda';

  @override
  String get keyPoints => 'Punti chiave';

  @override
  String get theoryComplete => 'Completare';

  @override
  String get excellentComplete => 'Eccellente!';

  @override
  String get goodComplete => 'Ottimo lavoro!';

  @override
  String get phaseResults => 'Risultati per fase';

  @override
  String get additionalStudy => 'Continua a studiare';

  @override
  String continueReviewWithCount(int count) {
    return 'Continua la revisione ($count rimanenti)';
  }

  @override
  String get totalStudied => 'Totale studiato';

  @override
  String get accuracyRate => 'Tasso di precisione';

  @override
  String get studyDays => 'Giorni di studio';

  @override
  String get studyTime => 'Tempo di studio';

  @override
  String get currentStreak => 'Serie attuale';

  @override
  String get longestStreak => 'Serie più lunga';

  @override
  String get streakEncouragement => 'Continua a studiare per migliorare!';

  @override
  String get noStudyYet => 'Ancora nessun dato di studio';

  @override
  String daysUnit(int count) {
    return '$count giorni';
  }

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String get selectDailyGoal => 'Seleziona obiettivo giornaliero';

  @override
  String get selectTargetLevel => 'Seleziona livello obiettivo';

  @override
  String get notificationMsg1 =>
      'Il tuo spagnolo ti aspetta! Pronto a fare un altro passo oggi?';

  @override
  String get notificationMsg2 =>
      'Ricordi cosa hai imparato ieri? Ripassare aiuta a ricordare meglio!';

  @override
  String get notificationMsg3 =>
      'Un po\' ogni giorno! Inizia la tua lezione di spagnolo oggi.';

  @override
  String get notificationMsg4 =>
      '¡Hola! Ci sei mancato. Studiamo spagnolo insieme oggi!';

  @override
  String get notificationMsg5 =>
      'Non interrompere la tua serie! Inizia a studiare adesso.';
}
