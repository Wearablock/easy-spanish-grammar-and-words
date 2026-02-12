/// 사용자 설정 키 상수
abstract class SettingKeys {
  // 학습 관련
  static const String dailyGoal = 'daily_goal';
  static const String reviewPriority = 'review_priority';
  static const String shuffleOptions = 'shuffle_options';
  static const String showExplanation = 'show_explanation';

  // 목표 레벨
  static const String targetLevel = 'target_level';
  static const String studyCategory = 'study_category';

  // 알림 관련
  static const String notificationEnabled = 'notification_enabled';
  static const String notificationHour = 'notification_hour';
  static const String notificationMinute = 'notification_minute';
  static const String streakReminder = 'streak_reminder';

  // 테마
  static const String themeMode = 'theme_mode';

  // 사운드 & 진동
  static const String soundEnabled = 'sound_enabled';
  static const String vibrationEnabled = 'vibration_enabled';

  // TTS
  static const String ttsAutoPlay = 'tts_auto_play';
  static const String ttsSpeechRate = 'tts_speech_rate';
  static const String ttsVoice = 'tts_voice';

  // 언어
  static const String locale = 'locale';
  static const String contentLocale = 'content_locale';

  // 프리미엄
  static const String isPremium = 'is_premium';
  static const String premiumPurchasedAt = 'premium_purchased_at';

  // 기타
  static const String firstLaunchDate = 'first_launch_date';
  static const String lastReviewPrompt = 'last_review_prompt';
  static const String reviewPromptCount = 'review_prompt_count';
  static const String onboardingCompleted = 'onboarding_completed';
}

/// 일일 학습 목표 옵션 (토픽 기준)
enum DailyGoalOption {
  oneTopic(1),
  twoTopics(2),
  threeTopics(3);

  final int topicCount;

  const DailyGoalOption(this.topicCount);

  static DailyGoalOption? fromValue(int value) {
    for (final option in DailyGoalOption.values) {
      if (option.topicCount == value) {
        return option;
      }
    }
    return null;
  }
}

/// 테마 모드 옵션
enum ThemeModeOption {
  system('system', '시스템 설정'),
  light('light', '라이트 모드'),
  dark('dark', '다크 모드');

  final String value;
  final String label;

  const ThemeModeOption(this.value, this.label);

  static ThemeModeOption fromValue(String value) {
    return ThemeModeOption.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ThemeModeOption.system,
    );
  }
}

/// 언어 옵션
enum LanguageOption {
  system('system', null),
  korean('ko', 'ko'),
  english('en', 'en'),
  japanese('ja', 'ja'),
  chineseSimplified('zh-Hans', 'zh-Hans'),
  chineseTraditional('zh-Hant', 'zh-Hant'),
  german('de', 'de'),
  french('fr', 'fr'),
  spanish('es', 'es'),
  portuguese('pt', 'pt'),
  italian('it', 'it'),
  russian('ru', 'ru'),
  arabic('ar', 'ar'),
  thai('th', 'th'),
  vietnamese('vi', 'vi'),
  indonesian('id', 'id');

  final String value;
  final String? localeCode;

  const LanguageOption(this.value, this.localeCode);

  /// 각 언어의 네이티브 이름 (시스템 옵션은 null → l10n 사용)
  String? get nativeLabel {
    switch (this) {
      case LanguageOption.system:
        return null; // l10n.languageSystem 사용
      case LanguageOption.korean:
        return '한국어';
      case LanguageOption.english:
        return 'English';
      case LanguageOption.japanese:
        return '日本語';
      case LanguageOption.chineseSimplified:
        return '简体中文';
      case LanguageOption.chineseTraditional:
        return '繁體中文';
      case LanguageOption.german:
        return 'Deutsch';
      case LanguageOption.french:
        return 'Français';
      case LanguageOption.spanish:
        return 'Español';
      case LanguageOption.portuguese:
        return 'Português';
      case LanguageOption.italian:
        return 'Italiano';
      case LanguageOption.russian:
        return 'Русский';
      case LanguageOption.arabic:
        return 'العربية';
      case LanguageOption.thai:
        return 'ไทย';
      case LanguageOption.vietnamese:
        return 'Tiếng Việt';
      case LanguageOption.indonesian:
        return 'Bahasa Indonesia';
    }
  }

  static LanguageOption fromValue(String value) {
    return LanguageOption.values.firstWhere(
      (e) => e.value == value,
      orElse: () => LanguageOption.system,
    );
  }
}
