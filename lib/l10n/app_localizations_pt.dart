// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Espanhol Fácil';

  @override
  String get appFullTitle => 'Espanhol Fácil - Gramática';

  @override
  String get home => 'Início';

  @override
  String get progress => 'Progresso';

  @override
  String get settings => 'Configurações';

  @override
  String get wrongAnswers => 'Erros';

  @override
  String error(String message) {
    return 'Erro: $message';
  }

  @override
  String get startStudy => 'Iniciar estudo';

  @override
  String get continueStudy => 'Continuar estudando';

  @override
  String get startReview => 'Revisar';

  @override
  String get todayStudy => 'Estudo de hoje';

  @override
  String get allTopicsCompleted => 'Todos os temas concluídos!';

  @override
  String get reviewEncouragement =>
      'Continue revisando para dominar o conteúdo.';

  @override
  String get nextTopic => 'Próximo tema';

  @override
  String questionsCount(int count) {
    return '$count questões';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '$count questões concluídas hoje';
  }

  @override
  String get todayGoal => 'Meta de hoje';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal temas';
  }

  @override
  String streakDays(int days) {
    return '$days dias seguidos!';
  }

  @override
  String get overallProgress => 'Progresso geral';

  @override
  String get mastered => 'Dominado';

  @override
  String get studiedOnce => 'Estudado pelo menos uma vez';

  @override
  String totalQuestions(int count) {
    return 'Total de $count questões';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total questões dominadas';
  }

  @override
  String get study => 'Estudo';

  @override
  String get notifications => 'Notificações';

  @override
  String get appSettings => 'Configurações do app';

  @override
  String get info => 'Informações';

  @override
  String get appVersion => 'Versão do app';

  @override
  String get termsAndPolicies => 'Termos e políticas';

  @override
  String get termsOfService => 'Termos de serviço';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get support => 'Suporte';

  @override
  String get data => 'Dados';

  @override
  String get resetStudyRecords => 'Redefinir registros';

  @override
  String get resetStudyRecordsDesc => 'Excluir todos os registros de estudo';

  @override
  String get resetStudyRecordsConfirm =>
      'Todos os registros de estudo serão excluídos.\nEsta ação não pode ser desfeita.';

  @override
  String get cannotOpenLink => 'Não foi possível abrir o link.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get reset => 'Redefinir';

  @override
  String get confirm => 'Confirmar';

  @override
  String get studyRecordsReset => 'Os registros de estudo foram redefinidos.';

  @override
  String get dailyStudyAmount => 'Quantidade de estudo diário';

  @override
  String topicsUnit(int count) {
    return '$count temas';
  }

  @override
  String get customSetting => 'Personalizado';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Selecionar tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Modo claro';

  @override
  String get themeDark => 'Modo escuro';

  @override
  String get studyComplete => 'Estudo concluído';

  @override
  String get goodJob => 'Bom trabalho!';

  @override
  String get goHome => 'Ir para o início';

  @override
  String get accuracy => 'Precisão';

  @override
  String get correct => 'Correto';

  @override
  String get wrong => 'Incorreto';

  @override
  String get timeSpent => 'Tempo gasto';

  @override
  String get wrongReview => 'Revisão de erros';

  @override
  String get spacedReview => 'Revisão espaçada';

  @override
  String get newLearning => 'Novo aprendizado';

  @override
  String get errorOccurred => 'Ocorreu um erro';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get stopStudy => 'Parar estudo';

  @override
  String get stopStudyConfirm =>
      'Deseja parar de estudar?\nSeu progresso será salvo.';

  @override
  String get continueStudyButton => 'Continuar';

  @override
  String get stop => 'Parar';

  @override
  String get levelProgress => 'Progresso por nível';

  @override
  String get reviewAvailable => 'Você tem questões para revisar!';

  @override
  String reviewWaiting(int count) {
    return '$count questões aguardando revisão';
  }

  @override
  String get welcome => 'Bem-vindo!';

  @override
  String get selectLevel => 'Selecione seu nível alvo';

  @override
  String get canChangeInSettings =>
      'Você pode alterar depois nas configurações';

  @override
  String get start => 'Iniciar';

  @override
  String get levelTarget => 'Nível alvo';

  @override
  String get levelNameA1 => 'Iniciante';

  @override
  String get levelNameA2 => 'Elementar';

  @override
  String get levelNameB1 => 'Intermediário';

  @override
  String get levelNameB2 => 'Intermediário alto';

  @override
  String get levelNameC1 => 'Avançado';

  @override
  String get levelNameC2 => 'Maestria';

  @override
  String get grammar => 'Gramática';

  @override
  String get vocabulary => 'Vocabulário';

  @override
  String get grammarAndVocabulary => 'Gramática & Vocabulário';

  @override
  String get noWrongAnswers => 'Sem erros!';

  @override
  String get noWrongAnswersDesc => 'Você está indo muito bem!\nContinue assim!';

  @override
  String wrongCount(int count) {
    return 'Errou $count vezes';
  }

  @override
  String get correctAnswer => 'Resposta correta';

  @override
  String get yourAnswer => 'Sua resposta';

  @override
  String get explanation => 'Explicação';

  @override
  String get premium => 'Premium';

  @override
  String get removeAds => 'Remover anúncios';

  @override
  String get premiumActivated => 'Premium ativado';

  @override
  String get purchase => 'Comprar';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get purchaseFailed => 'Falha na compra';

  @override
  String get purchasesRestored => 'Compras restauradas';

  @override
  String get productNotAvailable => 'Produto não disponível';

  @override
  String get studyNotification => 'Notificação de estudo';

  @override
  String get dailyNotification =>
      'Lembrete de estudo se ficar mais de um dia sem acessar';

  @override
  String get notificationOff => 'Notificações desativadas';

  @override
  String get notificationTime => 'Horário da notificação';

  @override
  String get notificationChannelName => 'Lembrete de estudo';

  @override
  String get notificationChannelDesc => 'Lembretes diários de estudo';

  @override
  String get notificationTitle => 'Espanhol Fácil';

  @override
  String get notificationBody => 'Hora de começar a estudar!';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get soundAndVibration => 'Som e vibração';

  @override
  String get soundEffects => 'Efeitos sonoros';

  @override
  String get soundEffectsDesc => 'Reproduzir som ao acertar/errar';

  @override
  String get vibration => 'Vibração';

  @override
  String get vibrationDesc => 'Vibração ao acertar/errar';

  @override
  String get ttsSettings => 'Configurações de voz';

  @override
  String get ttsAutoPlay => 'Reprodução automática';

  @override
  String get ttsAutoPlayDesc =>
      'Pronunciar espanhol automaticamente ao acertar';

  @override
  String get ttsSpeechRate => 'Velocidade';

  @override
  String get ttsVoice => 'Voz';

  @override
  String get ttsVoiceDefault => 'Padrão';

  @override
  String get ttsSpeedSlow => 'Lento';

  @override
  String get ttsSpeedNormal => 'Normal';

  @override
  String get ttsSpeedFast => 'Rápido';

  @override
  String get ttsTestPlay => 'Pré-visualizar';

  @override
  String get showHint => 'Ver dica';

  @override
  String get nextQuestion => 'Próxima pergunta';

  @override
  String get keyPoints => 'Pontos-chave';

  @override
  String get theoryComplete => 'Concluir';

  @override
  String get excellentComplete => 'Excelente!';

  @override
  String get goodComplete => 'Bom trabalho!';

  @override
  String get phaseResults => 'Resultados por fase';

  @override
  String get additionalStudy => 'Continuar estudando';

  @override
  String continueReviewWithCount(int count) {
    return 'Continuar revisão ($count restantes)';
  }

  @override
  String get totalStudied => 'Total estudado';

  @override
  String get accuracyRate => 'Taxa de acerto';

  @override
  String get studyDays => 'Dias de estudo';

  @override
  String get studyTime => 'Tempo de estudo';

  @override
  String get currentStreak => 'Sequência atual';

  @override
  String get longestStreak => 'Maior sequência';

  @override
  String get streakEncouragement => 'Continue estudando para evoluir!';

  @override
  String get noStudyYet => 'Ainda não há registros de estudo';

  @override
  String daysUnit(int count) {
    return '$count dias';
  }

  @override
  String minutes(int count) {
    return '$count min';
  }

  @override
  String get selectDailyGoal => 'Selecionar meta diária';

  @override
  String get selectTargetLevel => 'Selecionar nível alvo';

  @override
  String get notificationMsg1 =>
      'Seu espanhol está esperando! Pronto para dar mais um passo hoje?';

  @override
  String get notificationMsg2 =>
      'Lembra do que aprendeu ontem? Revisar ajuda a memorizar melhor!';

  @override
  String get notificationMsg3 =>
      'Um pouco por dia faz a diferença! Comece sua lição de espanhol hoje.';

  @override
  String get notificationMsg4 =>
      '¡Hola! Sentimos sua falta. Vamos estudar espanhol juntos hoje!';

  @override
  String get notificationMsg5 =>
      'Não quebre sua sequência! Comece a estudar agora.';

  @override
  String get howManyTopics => 'Quantos temas por dia?';

  @override
  String get oneTopic => '1 tema';

  @override
  String get twoTopics => '2 temas';

  @override
  String get threeTopics => '3 temas';

  @override
  String get lightStart => 'Início leve';

  @override
  String get moderateAmount => 'Quantidade moderada';

  @override
  String get intensiveStudy => 'Estudo intensivo';
}
