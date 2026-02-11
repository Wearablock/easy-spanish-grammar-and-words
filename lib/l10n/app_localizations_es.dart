// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Español Fácil';

  @override
  String get appFullTitle => 'Español Fácil - Gramática';

  @override
  String get home => 'Inicio';

  @override
  String get progress => 'Progreso';

  @override
  String get settings => 'Ajustes';

  @override
  String get wrongAnswers => 'Errores';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get startStudy => 'Empezar a estudiar';

  @override
  String get continueStudy => 'Continuar estudiando';

  @override
  String get startReview => 'Repasar';

  @override
  String get todayStudy => 'Estudio de hoy';

  @override
  String get allTopicsCompleted => '¡Todos los temas completados!';

  @override
  String get reviewEncouragement =>
      'Sigue repasando para dominar el contenido.';

  @override
  String get nextTopic => 'Siguiente tema';

  @override
  String questionsCount(int count) {
    return '$count preguntas';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '$count preguntas completadas hoy';
  }

  @override
  String get todayGoal => 'Meta de hoy';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal temas';
  }

  @override
  String streakDays(int days) {
    return '¡$days días seguidos!';
  }

  @override
  String get overallProgress => 'Progreso general';

  @override
  String get mastered => 'Dominado';

  @override
  String get studiedOnce => 'Estudiado al menos una vez';

  @override
  String totalQuestions(int count) {
    return '$count preguntas en total';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total preguntas dominadas';
  }

  @override
  String get study => 'Estudio';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get appSettings => 'Configuración';

  @override
  String get info => 'Información';

  @override
  String get appVersion => 'Versión de la app';

  @override
  String get termsAndPolicies => 'Términos y políticas';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get support => 'Soporte';

  @override
  String get data => 'Datos';

  @override
  String get resetStudyRecords => 'Restablecer registros';

  @override
  String get resetStudyRecordsDesc => 'Eliminar todos los registros de estudio';

  @override
  String get resetStudyRecordsConfirm =>
      'Se eliminarán todos los registros de estudio.\nEsta acción no se puede deshacer.';

  @override
  String get cannotOpenLink => 'No se puede abrir el enlace.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get reset => 'Restablecer';

  @override
  String get confirm => 'Confirmar';

  @override
  String get studyRecordsReset =>
      'Los registros de estudio se han restablecido.';

  @override
  String get dailyStudyAmount => 'Cantidad de estudio diario';

  @override
  String topicsUnit(int count) {
    return '$count temas';
  }

  @override
  String get customSetting => 'Personalizado';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Seleccionar tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Modo claro';

  @override
  String get themeDark => 'Modo oscuro';

  @override
  String get studyComplete => 'Estudio completado';

  @override
  String get goodJob => '¡Buen trabajo!';

  @override
  String get goHome => 'Ir al inicio';

  @override
  String get accuracy => 'Precisión';

  @override
  String get correct => 'Correcto';

  @override
  String get wrong => 'Incorrecto';

  @override
  String get timeSpent => 'Tiempo empleado';

  @override
  String get wrongReview => 'Repaso de errores';

  @override
  String get spacedReview => 'Repaso espaciado';

  @override
  String get newLearning => 'Nuevo aprendizaje';

  @override
  String get errorOccurred => 'Ha ocurrido un error';

  @override
  String get retry => 'Reintentar';

  @override
  String get stopStudy => 'Detener estudio';

  @override
  String get stopStudyConfirm =>
      '¿Quieres detener el estudio?\nTu progreso se guardará.';

  @override
  String get continueStudyButton => 'Continuar';

  @override
  String get stop => 'Detener';

  @override
  String get levelProgress => 'Progreso por nivel';

  @override
  String get reviewAvailable => '¡Tienes preguntas para repasar!';

  @override
  String reviewWaiting(int count) {
    return '$count preguntas esperando repaso';
  }

  @override
  String get welcome => '¡Bienvenido!';

  @override
  String get selectLevel => 'Selecciona tu nivel objetivo';

  @override
  String get canChangeInSettings => 'Puedes cambiarlo después en ajustes';

  @override
  String get start => 'Empezar';

  @override
  String get levelTarget => 'Nivel objetivo';

  @override
  String get levelNameA1 => 'Principiante';

  @override
  String get levelNameA2 => 'Elemental';

  @override
  String get levelNameB1 => 'Intermedio';

  @override
  String get levelNameB2 => 'Intermedio alto';

  @override
  String get levelNameC1 => 'Avanzado';

  @override
  String get levelNameC2 => 'Maestría';

  @override
  String get grammar => 'Gramática';

  @override
  String get vocabulary => 'Vocabulario';

  @override
  String get grammarAndVocabulary => 'Gramática & Vocabulario';

  @override
  String get noWrongAnswers => '¡Sin errores!';

  @override
  String get noWrongAnswersDesc =>
      '¡Lo estás haciendo genial!\nSigue así y sigue aprendiendo.';

  @override
  String wrongCount(int count) {
    return '$count veces incorrecto';
  }

  @override
  String get correctAnswer => 'Respuesta correcta';

  @override
  String get yourAnswer => 'Tu respuesta';

  @override
  String get explanation => 'Explicación';

  @override
  String get premium => 'Premium';

  @override
  String get removeAds => 'Eliminar anuncios';

  @override
  String get premiumActivated => 'Premium activado';

  @override
  String get purchase => 'Comprar';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get studyNotification => 'Notificación de estudio';

  @override
  String get dailyNotification =>
      'Recordatorio de estudio si no accedes en más de un día';

  @override
  String get notificationOff => 'Notificaciones desactivadas';

  @override
  String get notificationTime => 'Hora de notificación';

  @override
  String get notificationChannelName => 'Recordatorio de estudio';

  @override
  String get notificationChannelDesc => 'Recordatorios diarios de estudio';

  @override
  String get notificationTitle => 'Español Fácil';

  @override
  String get notificationBody => '¡Es hora de empezar a estudiar!';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get soundAndVibration => 'Sonido y vibración';

  @override
  String get soundEffects => 'Efectos de sonido';

  @override
  String get soundEffectsDesc => 'Reproducir sonido al acertar/fallar';

  @override
  String get vibration => 'Vibración';

  @override
  String get vibrationDesc => 'Vibración al acertar/fallar';

  @override
  String get ttsSettings => 'Configuración de voz';

  @override
  String get ttsAutoPlay => 'Reproducción automática';

  @override
  String get ttsAutoPlayDesc => 'Pronunciar español automáticamente al acertar';

  @override
  String get ttsSpeechRate => 'Velocidad';

  @override
  String get ttsVoice => 'Voz';

  @override
  String get ttsVoiceDefault => 'Predeterminada';

  @override
  String get ttsSpeedSlow => 'Lento';

  @override
  String get ttsSpeedNormal => 'Normal';

  @override
  String get ttsSpeedFast => 'Rápido';

  @override
  String get ttsTestPlay => 'Vista previa';

  @override
  String get showHint => 'Ver pista';

  @override
  String get nextQuestion => 'Siguiente pregunta';

  @override
  String get keyPoints => 'Puntos clave';

  @override
  String get theoryComplete => 'Completar';

  @override
  String get excellentComplete => '¡Excelente!';

  @override
  String get goodComplete => '¡Buen trabajo!';

  @override
  String get phaseResults => 'Resultados por fase';

  @override
  String get additionalStudy => 'Seguir estudiando';

  @override
  String continueReviewWithCount(int count) {
    return 'Seguir repasando ($count restantes)';
  }

  @override
  String get totalStudied => 'Total estudiado';

  @override
  String get accuracyRate => 'Tasa de acierto';

  @override
  String get studyDays => 'Días de estudio';

  @override
  String get studyTime => 'Tiempo de estudio';

  @override
  String get currentStreak => 'Racha actual';

  @override
  String get longestStreak => 'Racha más larga';

  @override
  String get streakEncouragement => '¡Sigue estudiando para mejorar!';

  @override
  String get noStudyYet => 'Aún no hay registros de estudio';

  @override
  String daysUnit(int count) {
    return '$count días';
  }

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String get selectDailyGoal => 'Seleccionar meta diaria';

  @override
  String get selectTargetLevel => 'Seleccionar nivel objetivo';

  @override
  String get notificationMsg1 =>
      '¡Tu español te espera! ¿Listo para dar otro paso hoy?';

  @override
  String get notificationMsg2 =>
      '¿Recuerdas lo que aprendiste ayer? ¡Repasar ayuda a recordar más!';

  @override
  String get notificationMsg3 =>
      '¡Un poco cada día! Empieza tu lección de español hoy.';

  @override
  String get notificationMsg4 =>
      '¡Hola! Te echamos de menos. ¡Estudiemos español juntos hoy!';

  @override
  String get notificationMsg5 =>
      '¡No rompas tu racha! Empieza a estudiar ahora.';
}
