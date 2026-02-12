// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'إسبانية سهلة';

  @override
  String get appFullTitle => 'إسبانية سهلة - قواعد وكلمات';

  @override
  String get home => 'الرئيسية';

  @override
  String get progress => 'التقدم';

  @override
  String get settings => 'الإعدادات';

  @override
  String get wrongAnswers => 'الأخطاء';

  @override
  String error(String message) {
    return 'خطأ: $message';
  }

  @override
  String get startStudy => 'بدء الدراسة';

  @override
  String get continueStudy => 'متابعة الدراسة';

  @override
  String get startReview => 'مراجعة';

  @override
  String get todayStudy => 'دراسة اليوم';

  @override
  String get allTopicsCompleted => 'تم إكمال جميع المواضيع!';

  @override
  String get reviewEncouragement => 'استمر في المراجعة لإتقان المحتوى.';

  @override
  String get nextTopic => 'الموضوع التالي';

  @override
  String questionsCount(int count) {
    return '$count أسئلة';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return 'تم إكمال $count سؤال اليوم';
  }

  @override
  String get todayGoal => 'هدف اليوم';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal مواضيع';
  }

  @override
  String streakDays(int days) {
    return '$days أيام متتالية!';
  }

  @override
  String get overallProgress => 'التقدم العام';

  @override
  String get mastered => 'متقن';

  @override
  String get studiedOnce => 'تمت دراسته مرة واحدة على الأقل';

  @override
  String totalQuestions(int count) {
    return 'إجمالي $count سؤال';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total سؤال متقن';
  }

  @override
  String get study => 'الدراسة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get appSettings => 'إعدادات التطبيق';

  @override
  String get info => 'معلومات';

  @override
  String get appVersion => 'إصدار التطبيق';

  @override
  String get termsAndPolicies => 'الشروط والسياسات';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get support => 'الدعم';

  @override
  String get data => 'البيانات';

  @override
  String get resetStudyRecords => 'إعادة تعيين السجلات';

  @override
  String get resetStudyRecordsDesc => 'حذف جميع سجلات الدراسة';

  @override
  String get resetStudyRecordsConfirm =>
      'سيتم حذف جميع سجلات الدراسة.\nلا يمكن التراجع عن هذا الإجراء.';

  @override
  String get cannotOpenLink => 'تعذر فتح الرابط.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get confirm => 'تأكيد';

  @override
  String get studyRecordsReset => 'تمت إعادة تعيين سجلات الدراسة.';

  @override
  String get dailyStudyAmount => 'كمية الدراسة اليومية';

  @override
  String topicsUnit(int count) {
    return '$count مواضيع';
  }

  @override
  String get customSetting => 'مخصص';

  @override
  String get theme => 'المظهر';

  @override
  String get selectTheme => 'اختيار المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'الوضع الفاتح';

  @override
  String get themeDark => 'الوضع الداكن';

  @override
  String get studyComplete => 'اكتملت الدراسة';

  @override
  String get goodJob => 'أحسنت!';

  @override
  String get goHome => 'العودة للرئيسية';

  @override
  String get accuracy => 'الدقة';

  @override
  String get correct => 'صحيح';

  @override
  String get wrong => 'خطأ';

  @override
  String get timeSpent => 'الوقت المستغرق';

  @override
  String get wrongReview => 'مراجعة الأخطاء';

  @override
  String get spacedReview => 'المراجعة المتباعدة';

  @override
  String get newLearning => 'تعلم جديد';

  @override
  String get errorOccurred => 'حدث خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get stopStudy => 'إيقاف الدراسة';

  @override
  String get stopStudyConfirm => 'هل تريد إيقاف الدراسة؟\nسيتم حفظ تقدمك.';

  @override
  String get continueStudyButton => 'متابعة';

  @override
  String get stop => 'إيقاف';

  @override
  String get levelProgress => 'التقدم حسب المستوى';

  @override
  String get reviewAvailable => 'لديك أسئلة للمراجعة!';

  @override
  String reviewWaiting(int count) {
    return '$count أسئلة بانتظار المراجعة';
  }

  @override
  String get welcome => 'مرحباً!';

  @override
  String get selectLevel => 'اختر المستوى المستهدف';

  @override
  String get canChangeInSettings => 'يمكنك تغييره لاحقاً في الإعدادات';

  @override
  String get start => 'ابدأ';

  @override
  String get levelTarget => 'المستوى المستهدف';

  @override
  String get levelNameA1 => 'مبتدئ';

  @override
  String get levelNameA2 => 'أساسي';

  @override
  String get levelNameB1 => 'متوسط';

  @override
  String get levelNameB2 => 'فوق المتوسط';

  @override
  String get levelNameC1 => 'متقدم';

  @override
  String get levelNameC2 => 'إتقان';

  @override
  String get grammar => 'القواعد';

  @override
  String get vocabulary => 'المفردات';

  @override
  String get grammarAndVocabulary => 'القواعد والمفردات';

  @override
  String get noWrongAnswers => 'لا توجد أخطاء!';

  @override
  String get noWrongAnswersDesc => 'أنت تبلي بلاءً حسناً!\nاستمر في ذلك!';

  @override
  String wrongCount(int count) {
    return 'خطأ $count مرات';
  }

  @override
  String get correctAnswer => 'الإجابة الصحيحة';

  @override
  String get yourAnswer => 'إجابتك';

  @override
  String get explanation => 'الشرح';

  @override
  String get premium => 'مميز';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get premiumActivated => 'تم تفعيل المميز';

  @override
  String get purchase => 'شراء';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get purchaseFailed => 'فشل الشراء';

  @override
  String get purchasesRestored => 'تم استعادة المشتريات';

  @override
  String get productNotAvailable => 'المنتج غير متاح';

  @override
  String get studyNotification => 'تذكير الدراسة';

  @override
  String get dailyNotification => 'تذكير بالدراسة عند عدم الدخول لأكثر من يوم';

  @override
  String get notificationOff => 'الإشعارات معطلة';

  @override
  String get notificationTime => 'وقت الإشعار';

  @override
  String get notificationChannelName => 'تذكير الدراسة';

  @override
  String get notificationChannelDesc => 'تذكيرات يومية للدراسة';

  @override
  String get notificationTitle => 'إسبانية سهلة';

  @override
  String get notificationBody => 'حان وقت بدء الدراسة!';

  @override
  String get language => 'اللغة';

  @override
  String get selectLanguage => 'اختيار اللغة';

  @override
  String get languageSystem => 'النظام';

  @override
  String get soundAndVibration => 'الصوت والاهتزاز';

  @override
  String get soundEffects => 'المؤثرات الصوتية';

  @override
  String get soundEffectsDesc => 'تشغيل صوت عند الإجابة الصحيحة/الخاطئة';

  @override
  String get vibration => 'الاهتزاز';

  @override
  String get vibrationDesc => 'اهتزاز عند الإجابة الصحيحة/الخاطئة';

  @override
  String get ttsSettings => 'إعدادات الصوت';

  @override
  String get ttsAutoPlay => 'تشغيل تلقائي';

  @override
  String get ttsAutoPlayDesc => 'نطق الإسبانية تلقائياً عند الإجابة الصحيحة';

  @override
  String get ttsSpeechRate => 'السرعة';

  @override
  String get ttsVoice => 'الصوت';

  @override
  String get ttsVoiceDefault => 'الافتراضي';

  @override
  String get ttsSpeedSlow => 'بطيء';

  @override
  String get ttsSpeedNormal => 'عادي';

  @override
  String get ttsSpeedFast => 'سريع';

  @override
  String get ttsTestPlay => 'معاينة';

  @override
  String get showHint => 'عرض التلميح';

  @override
  String get nextQuestion => 'السؤال التالي';

  @override
  String get keyPoints => 'النقاط الرئيسية';

  @override
  String get theoryComplete => 'إكمال';

  @override
  String get excellentComplete => 'ممتاز!';

  @override
  String get goodComplete => 'عمل جيد!';

  @override
  String get phaseResults => 'نتائج المراحل';

  @override
  String get additionalStudy => 'متابعة الدراسة';

  @override
  String continueReviewWithCount(int count) {
    return 'متابعة المراجعة ($count متبقية)';
  }

  @override
  String get totalStudied => 'إجمالي المدروس';

  @override
  String get accuracyRate => 'نسبة الدقة';

  @override
  String get studyDays => 'أيام الدراسة';

  @override
  String get studyTime => 'وقت الدراسة';

  @override
  String get currentStreak => 'السلسلة الحالية';

  @override
  String get longestStreak => 'أطول سلسلة';

  @override
  String get streakEncouragement => 'استمر في الدراسة لتتحسن!';

  @override
  String get noStudyYet => 'لا توجد سجلات دراسة بعد';

  @override
  String daysUnit(int count) {
    return '$count أيام';
  }

  @override
  String minutes(int count) {
    return '$count دقيقة';
  }

  @override
  String get selectDailyGoal => 'اختيار الهدف اليومي';

  @override
  String get selectTargetLevel => 'اختيار المستوى المستهدف';

  @override
  String get notificationMsg1 =>
      'مهاراتك في الإسبانية بانتظارك! هل أنت مستعد لخطوة أخرى اليوم؟';

  @override
  String get notificationMsg2 =>
      'هل تتذكر ما تعلمته بالأمس؟ المراجعة تساعدك على التذكر لفترة أطول!';

  @override
  String get notificationMsg3 =>
      'قليل كل يوم يصنع فرقاً كبيراً! ابدأ درس الإسبانية اليوم.';

  @override
  String get notificationMsg4 =>
      '¡Hola! افتقدناك. لنتعلم الإسبانية معاً اليوم!';

  @override
  String get notificationMsg5 => 'لا تكسر سلسلة تعلمك! ابدأ الدراسة الآن.';
}
