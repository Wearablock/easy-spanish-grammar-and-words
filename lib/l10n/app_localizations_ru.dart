// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Испанский Легко';

  @override
  String get appFullTitle => 'Испанский Легко - Грамматика';

  @override
  String get home => 'Главная';

  @override
  String get progress => 'Прогресс';

  @override
  String get settings => 'Настройки';

  @override
  String get wrongAnswers => 'Ошибки';

  @override
  String error(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get startStudy => 'Начать обучение';

  @override
  String get continueStudy => 'Продолжить обучение';

  @override
  String get startReview => 'Повторить';

  @override
  String get todayStudy => 'Сегодняшнее обучение';

  @override
  String get allTopicsCompleted => 'Все темы пройдены!';

  @override
  String get reviewEncouragement =>
      'Продолжайте повторять для закрепления материала.';

  @override
  String get nextTopic => 'Следующая тема';

  @override
  String questionsCount(int count) {
    return '$count вопросов';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '$count вопросов выполнено сегодня';
  }

  @override
  String get todayGoal => 'Цель на сегодня';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal тем';
  }

  @override
  String streakDays(int days) {
    return '$days дней подряд!';
  }

  @override
  String get overallProgress => 'Общий прогресс';

  @override
  String get mastered => 'Освоено';

  @override
  String get studiedOnce => 'Изучено хотя бы раз';

  @override
  String totalQuestions(int count) {
    return 'Всего $count вопросов';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total вопросов освоено';
  }

  @override
  String get study => 'Обучение';

  @override
  String get notifications => 'Уведомления';

  @override
  String get appSettings => 'Настройки приложения';

  @override
  String get info => 'Информация';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get termsAndPolicies => 'Условия и политики';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get support => 'Поддержка';

  @override
  String get data => 'Данные';

  @override
  String get resetStudyRecords => 'Сбросить данные';

  @override
  String get resetStudyRecordsDesc => 'Удалить все данные обучения';

  @override
  String get resetStudyRecordsConfirm =>
      'Все данные обучения будут удалены.\nЭто действие нельзя отменить.';

  @override
  String get cannotOpenLink => 'Не удается открыть ссылку.';

  @override
  String get cancel => 'Отмена';

  @override
  String get reset => 'Сбросить';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get studyRecordsReset => 'Данные обучения сброшены.';

  @override
  String get dailyStudyAmount => 'Ежедневный объём обучения';

  @override
  String topicsUnit(int count) {
    return '$count тем';
  }

  @override
  String get customSetting => 'Настроить';

  @override
  String get theme => 'Тема';

  @override
  String get selectTheme => 'Выбрать тему';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая тема';

  @override
  String get themeDark => 'Тёмная тема';

  @override
  String get studyComplete => 'Обучение завершено';

  @override
  String get goodJob => 'Отличная работа!';

  @override
  String get goHome => 'На главную';

  @override
  String get accuracy => 'Точность';

  @override
  String get correct => 'Правильно';

  @override
  String get wrong => 'Неправильно';

  @override
  String get timeSpent => 'Затраченное время';

  @override
  String get wrongReview => 'Повторение ошибок';

  @override
  String get spacedReview => 'Интервальное повторение';

  @override
  String get newLearning => 'Новый материал';

  @override
  String get errorOccurred => 'Произошла ошибка';

  @override
  String get retry => 'Повторить';

  @override
  String get stopStudy => 'Остановить обучение';

  @override
  String get stopStudyConfirm =>
      'Хотите остановить обучение?\nВаш прогресс будет сохранён.';

  @override
  String get continueStudyButton => 'Продолжить';

  @override
  String get stop => 'Остановить';

  @override
  String get levelProgress => 'Прогресс по уровням';

  @override
  String get reviewAvailable => 'Есть вопросы для повторения!';

  @override
  String reviewWaiting(int count) {
    return '$count вопросов ожидают повторения';
  }

  @override
  String get welcome => 'Добро пожаловать!';

  @override
  String get selectLevel => 'Выберите целевой уровень';

  @override
  String get canChangeInSettings => 'Можно изменить позже в настройках';

  @override
  String get start => 'Начать';

  @override
  String get levelTarget => 'Целевой уровень';

  @override
  String get levelNameA1 => 'Начальный';

  @override
  String get levelNameA2 => 'Элементарный';

  @override
  String get levelNameB1 => 'Средний';

  @override
  String get levelNameB2 => 'Выше среднего';

  @override
  String get levelNameC1 => 'Продвинутый';

  @override
  String get levelNameC2 => 'Мастерство';

  @override
  String get grammar => 'Грамматика';

  @override
  String get vocabulary => 'Словарный запас';

  @override
  String get grammarAndVocabulary => 'Грамматика и словарный запас';

  @override
  String get noWrongAnswers => 'Нет ошибок!';

  @override
  String get noWrongAnswersDesc => 'Вы отлично справляетесь!\nТак держать!';

  @override
  String wrongCount(int count) {
    return 'Ошибок: $count';
  }

  @override
  String get correctAnswer => 'Правильный ответ';

  @override
  String get yourAnswer => 'Ваш ответ';

  @override
  String get explanation => 'Объяснение';

  @override
  String get premium => 'Премиум';

  @override
  String get removeAds => 'Убрать рекламу';

  @override
  String get premiumActivated => 'Премиум активирован';

  @override
  String get purchase => 'Купить';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get purchaseFailed => 'Покупка не удалась';

  @override
  String get purchasesRestored => 'Покупки восстановлены';

  @override
  String get productNotAvailable => 'Товар недоступен';

  @override
  String get studyNotification => 'Напоминание об обучении';

  @override
  String get dailyNotification =>
      'Напоминание об учёбе при отсутствии более суток';

  @override
  String get notificationOff => 'Уведомления выключены';

  @override
  String get notificationTime => 'Время уведомления';

  @override
  String get notificationChannelName => 'Напоминание об обучении';

  @override
  String get notificationChannelDesc => 'Ежедневные напоминания об обучении';

  @override
  String get notificationTitle => 'Испанский Легко';

  @override
  String get notificationBody => 'Пора начинать обучение!';

  @override
  String get language => 'Язык';

  @override
  String get selectLanguage => 'Выбрать язык';

  @override
  String get languageSystem => 'Системный';

  @override
  String get soundAndVibration => 'Звук и вибрация';

  @override
  String get soundEffects => 'Звуковые эффекты';

  @override
  String get soundEffectsDesc => 'Звук при правильном/неправильном ответе';

  @override
  String get vibration => 'Вибрация';

  @override
  String get vibrationDesc => 'Вибрация при правильном/неправильном ответе';

  @override
  String get ttsSettings => 'Настройки голоса';

  @override
  String get ttsAutoPlay => 'Автовоспроизведение';

  @override
  String get ttsAutoPlayDesc =>
      'Автоматическое произношение при правильном ответе';

  @override
  String get ttsSpeechRate => 'Скорость';

  @override
  String get ttsVoice => 'Голос';

  @override
  String get ttsVoiceDefault => 'По умолчанию';

  @override
  String get ttsSpeedSlow => 'Медленно';

  @override
  String get ttsSpeedNormal => 'Нормально';

  @override
  String get ttsSpeedFast => 'Быстро';

  @override
  String get ttsTestPlay => 'Предпросмотр';

  @override
  String get showHint => 'Показать подсказку';

  @override
  String get nextQuestion => 'Следующий вопрос';

  @override
  String get keyPoints => 'Ключевые моменты';

  @override
  String get theoryComplete => 'Завершить';

  @override
  String get excellentComplete => 'Отлично!';

  @override
  String get goodComplete => 'Хорошая работа!';

  @override
  String get phaseResults => 'Результаты по этапам';

  @override
  String get additionalStudy => 'Продолжить обучение';

  @override
  String continueReviewWithCount(int count) {
    return 'Продолжить повторение (осталось $count)';
  }

  @override
  String get totalStudied => 'Всего изучено';

  @override
  String get accuracyRate => 'Точность';

  @override
  String get studyDays => 'Дней обучения';

  @override
  String get studyTime => 'Время обучения';

  @override
  String get currentStreak => 'Текущая серия';

  @override
  String get longestStreak => 'Лучшая серия';

  @override
  String get streakEncouragement => 'Продолжайте учиться, чтобы расти!';

  @override
  String get noStudyYet => 'Пока нет данных об обучении';

  @override
  String daysUnit(int count) {
    return '$count дн.';
  }

  @override
  String minutes(int count) {
    return '$count мин';
  }

  @override
  String get selectDailyGoal => 'Выбрать дневную цель';

  @override
  String get selectTargetLevel => 'Выбрать целевой уровень';

  @override
  String get notificationMsg1 =>
      'Твой испанский ждёт тебя! Готов сделать ещё один шаг сегодня?';

  @override
  String get notificationMsg2 =>
      'Помнишь, что учил вчера? Повторение помогает запомнить надолго!';

  @override
  String get notificationMsg3 =>
      'Каждый день понемногу! Начни урок испанского сегодня.';

  @override
  String get notificationMsg4 =>
      '¡Hola! Мы скучали. Давай учить испанский вместе сегодня!';

  @override
  String get notificationMsg5 =>
      'Не прерывай свою серию! Начни заниматься прямо сейчас.';

  @override
  String get howManyTopics => 'Сколько тем в день?';

  @override
  String get oneTopic => '1 тема';

  @override
  String get twoTopics => '2 темы';

  @override
  String get threeTopics => '3 темы';

  @override
  String get lightStart => 'Лёгкий старт';

  @override
  String get moderateAmount => 'Умеренная нагрузка';

  @override
  String get intensiveStudy => 'Интенсивное обучение';

  @override
  String get topicList => 'Список тем';

  @override
  String get notStudiedYet => 'Не изучено';

  @override
  String get studiedLabel => 'Изучено';

  @override
  String topicCount(int count) {
    return '$count тем';
  }

  @override
  String get speakingPractice => 'Разговорная практика';

  @override
  String get speakingTest => 'Разговорный тест';

  @override
  String get speakingBrowseAll => 'Все фразы';

  @override
  String get speakingFeatureDesc =>
      'Тренируйте десятки вариантов одной фразы: смена подлежащего, отрицание, вопрос, замена слов.';

  @override
  String get practice => 'Практика';

  @override
  String get test => 'Тест';

  @override
  String cardsCount(int count) {
    return 'Карточек: $count';
  }

  @override
  String loadFailedError(String error) {
    return 'Ошибка загрузки: $error';
  }

  @override
  String get noSeeds => 'Базовых фраз нет.';

  @override
  String get showMeaning => 'Показать значение';

  @override
  String get speakAgain => 'Сказать снова';

  @override
  String get nextCard => 'Далее';

  @override
  String get viewResult => 'Результат';

  @override
  String get listening => 'Слушаю…';

  @override
  String get tapMicToSpeak => 'Нажмите микрофон и повторите';

  @override
  String get iSaid => 'Вы сказали';

  @override
  String get correctAnswerLabel => 'Ответ';

  @override
  String get micPermissionRequired =>
      'Нужны разрешения микрофона и распознавания речи. Включите в настройках.';

  @override
  String speechError(String error) {
    return 'Ошибка распознавания: $error';
  }

  @override
  String get practiceResult => 'Результат практики';

  @override
  String get testResult => 'Результат теста';

  @override
  String passedOfTotal(int passed, int total) {
    return '$passed / $total пройдено';
  }

  @override
  String averageAccuracy(String percent) {
    return 'Средняя точность $percent';
  }

  @override
  String get testPassed => '🎉 Сдано!';

  @override
  String get testFailed => 'Почти. Попробуйте ещё раз!';

  @override
  String get sayInSpanishHint => 'Скажите это по-испански';

  @override
  String get variationBase => 'Базовая фраза';

  @override
  String variationSubject(String subject) {
    return 'Подлежащее · $subject';
  }

  @override
  String get variationNegative => 'Отрицание';

  @override
  String get variationInterrogative => 'Вопрос';

  @override
  String variationNounSwap(String noun) {
    return 'Замена слова · $noun';
  }

  @override
  String get variationPhrase => 'Выражение';

  @override
  String get feedbackPerfect => 'Идеально! 🎉';

  @override
  String get feedbackGreat => 'Отлично! 👏';

  @override
  String get feedbackGood => 'Хорошо. Ещё раз!';

  @override
  String get feedbackKeepPractice => 'Продолжайте практиковаться.';

  @override
  String get feedbackTryAgain => 'Попробуйте снова.';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String attemptCounter(int current, int total) {
    return 'Попытка $current/$total';
  }

  @override
  String get playHint => 'Подсказка произношения';

  @override
  String get speakingReview => 'Повторение разговора';

  @override
  String speakingReviewDue(int count) {
    return 'Карточек к повторению: $count';
  }

  @override
  String get noReviewDue => 'Нет карточек для повторения.\nДо следующего раза!';
}
