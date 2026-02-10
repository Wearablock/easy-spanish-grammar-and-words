import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('th'),
    Locale('vi'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// 앱 제목 (홈 화면 표시용)
  ///
  /// In ko, this message translates to:
  /// **'쉬운 스페인어'**
  String get appTitle;

  /// 앱 전체 제목 (스토어 등)
  ///
  /// In ko, this message translates to:
  /// **'쉬운 스페인어 - 문법 & 단어'**
  String get appFullTitle;

  /// No description provided for @home.
  ///
  /// In ko, this message translates to:
  /// **'홈'**
  String get home;

  /// No description provided for @progress.
  ///
  /// In ko, this message translates to:
  /// **'진행률'**
  String get progress;

  /// No description provided for @settings.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settings;

  /// No description provided for @wrongAnswers.
  ///
  /// In ko, this message translates to:
  /// **'오답노트'**
  String get wrongAnswers;

  /// No description provided for @error.
  ///
  /// In ko, this message translates to:
  /// **'오류: {message}'**
  String error(String message);

  /// No description provided for @startStudy.
  ///
  /// In ko, this message translates to:
  /// **'학습 시작하기'**
  String get startStudy;

  /// No description provided for @continueStudy.
  ///
  /// In ko, this message translates to:
  /// **'학습 이어하기'**
  String get continueStudy;

  /// No description provided for @startReview.
  ///
  /// In ko, this message translates to:
  /// **'복습하기'**
  String get startReview;

  /// No description provided for @todayStudy.
  ///
  /// In ko, this message translates to:
  /// **'오늘의 학습'**
  String get todayStudy;

  /// No description provided for @allTopicsCompleted.
  ///
  /// In ko, this message translates to:
  /// **'모든 주제 학습 완료!'**
  String get allTopicsCompleted;

  /// No description provided for @reviewEncouragement.
  ///
  /// In ko, this message translates to:
  /// **'복습을 통해 실력을 더욱 쌓아보세요.'**
  String get reviewEncouragement;

  /// No description provided for @nextTopic.
  ///
  /// In ko, this message translates to:
  /// **'다음 주제'**
  String get nextTopic;

  /// No description provided for @questionsCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}문제'**
  String questionsCount(int count);

  /// No description provided for @todayQuestionsCompleted.
  ///
  /// In ko, this message translates to:
  /// **'오늘 {count}문제 학습 완료'**
  String todayQuestionsCompleted(int count);

  /// No description provided for @todayGoal.
  ///
  /// In ko, this message translates to:
  /// **'오늘의 목표'**
  String get todayGoal;

  /// No description provided for @topicsProgress.
  ///
  /// In ko, this message translates to:
  /// **'{studied}/{goal} 주제'**
  String topicsProgress(int studied, int goal);

  /// No description provided for @streakDays.
  ///
  /// In ko, this message translates to:
  /// **'연속 {days}일째 학습 중!'**
  String streakDays(int days);

  /// No description provided for @overallProgress.
  ///
  /// In ko, this message translates to:
  /// **'전체 진행률'**
  String get overallProgress;

  /// No description provided for @mastered.
  ///
  /// In ko, this message translates to:
  /// **'완전 습득'**
  String get mastered;

  /// No description provided for @studiedOnce.
  ///
  /// In ko, this message translates to:
  /// **'1회 이상 학습'**
  String get studiedOnce;

  /// No description provided for @totalQuestions.
  ///
  /// In ko, this message translates to:
  /// **'총 {count}문제'**
  String totalQuestions(int count);

  /// No description provided for @questionsMastered.
  ///
  /// In ko, this message translates to:
  /// **'{count} / {total} 문제 완전 습득'**
  String questionsMastered(int count, int total);

  /// No description provided for @study.
  ///
  /// In ko, this message translates to:
  /// **'학습'**
  String get study;

  /// No description provided for @notifications.
  ///
  /// In ko, this message translates to:
  /// **'알림'**
  String get notifications;

  /// No description provided for @appSettings.
  ///
  /// In ko, this message translates to:
  /// **'앱 설정'**
  String get appSettings;

  /// No description provided for @info.
  ///
  /// In ko, this message translates to:
  /// **'정보'**
  String get info;

  /// No description provided for @appVersion.
  ///
  /// In ko, this message translates to:
  /// **'앱 버전'**
  String get appVersion;

  /// No description provided for @termsAndPolicies.
  ///
  /// In ko, this message translates to:
  /// **'약관 및 정책'**
  String get termsAndPolicies;

  /// No description provided for @termsOfService.
  ///
  /// In ko, this message translates to:
  /// **'이용약관'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In ko, this message translates to:
  /// **'개인정보 처리방침'**
  String get privacyPolicy;

  /// No description provided for @support.
  ///
  /// In ko, this message translates to:
  /// **'고객 지원'**
  String get support;

  /// No description provided for @data.
  ///
  /// In ko, this message translates to:
  /// **'데이터'**
  String get data;

  /// No description provided for @resetStudyRecords.
  ///
  /// In ko, this message translates to:
  /// **'학습 기록 초기화'**
  String get resetStudyRecords;

  /// No description provided for @resetStudyRecordsDesc.
  ///
  /// In ko, this message translates to:
  /// **'모든 학습 기록을 삭제합니다'**
  String get resetStudyRecordsDesc;

  /// No description provided for @resetStudyRecordsConfirm.
  ///
  /// In ko, this message translates to:
  /// **'모든 학습 기록이 삭제됩니다.\n이 작업은 되돌릴 수 없습니다.'**
  String get resetStudyRecordsConfirm;

  /// No description provided for @cannotOpenLink.
  ///
  /// In ko, this message translates to:
  /// **'링크를 열 수 없습니다.'**
  String get cannotOpenLink;

  /// No description provided for @cancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In ko, this message translates to:
  /// **'초기화'**
  String get reset;

  /// No description provided for @confirm.
  ///
  /// In ko, this message translates to:
  /// **'확인'**
  String get confirm;

  /// No description provided for @studyRecordsReset.
  ///
  /// In ko, this message translates to:
  /// **'학습 기록이 초기화되었습니다.'**
  String get studyRecordsReset;

  /// No description provided for @dailyStudyAmount.
  ///
  /// In ko, this message translates to:
  /// **'일일 학습량'**
  String get dailyStudyAmount;

  /// No description provided for @topicsUnit.
  ///
  /// In ko, this message translates to:
  /// **'{count}주제'**
  String topicsUnit(int count);

  /// No description provided for @customSetting.
  ///
  /// In ko, this message translates to:
  /// **'직접 설정'**
  String get customSetting;

  /// No description provided for @theme.
  ///
  /// In ko, this message translates to:
  /// **'테마'**
  String get theme;

  /// No description provided for @selectTheme.
  ///
  /// In ko, this message translates to:
  /// **'테마 선택'**
  String get selectTheme;

  /// No description provided for @themeSystem.
  ///
  /// In ko, this message translates to:
  /// **'시스템 설정'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In ko, this message translates to:
  /// **'라이트 모드'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In ko, this message translates to:
  /// **'다크 모드'**
  String get themeDark;

  /// No description provided for @studyComplete.
  ///
  /// In ko, this message translates to:
  /// **'학습 완료'**
  String get studyComplete;

  /// No description provided for @goodJob.
  ///
  /// In ko, this message translates to:
  /// **'수고하셨습니다'**
  String get goodJob;

  /// No description provided for @goHome.
  ///
  /// In ko, this message translates to:
  /// **'홈으로'**
  String get goHome;

  /// No description provided for @accuracy.
  ///
  /// In ko, this message translates to:
  /// **'정답률'**
  String get accuracy;

  /// No description provided for @correct.
  ///
  /// In ko, this message translates to:
  /// **'정답'**
  String get correct;

  /// No description provided for @wrong.
  ///
  /// In ko, this message translates to:
  /// **'오답'**
  String get wrong;

  /// No description provided for @timeSpent.
  ///
  /// In ko, this message translates to:
  /// **'소요 시간'**
  String get timeSpent;

  /// No description provided for @wrongReview.
  ///
  /// In ko, this message translates to:
  /// **'오답 복습'**
  String get wrongReview;

  /// No description provided for @spacedReview.
  ///
  /// In ko, this message translates to:
  /// **'망각곡선 복습'**
  String get spacedReview;

  /// No description provided for @newLearning.
  ///
  /// In ko, this message translates to:
  /// **'신규 학습'**
  String get newLearning;

  /// No description provided for @errorOccurred.
  ///
  /// In ko, this message translates to:
  /// **'오류가 발생했습니다'**
  String get errorOccurred;

  /// No description provided for @retry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도'**
  String get retry;

  /// No description provided for @stopStudy.
  ///
  /// In ko, this message translates to:
  /// **'학습 중단'**
  String get stopStudy;

  /// No description provided for @stopStudyConfirm.
  ///
  /// In ko, this message translates to:
  /// **'학습을 중단하시겠습니까?\n현재까지의 진행 상황은 저장됩니다.'**
  String get stopStudyConfirm;

  /// No description provided for @continueStudyButton.
  ///
  /// In ko, this message translates to:
  /// **'계속 학습'**
  String get continueStudyButton;

  /// No description provided for @stop.
  ///
  /// In ko, this message translates to:
  /// **'중단'**
  String get stop;

  /// No description provided for @levelProgress.
  ///
  /// In ko, this message translates to:
  /// **'레벨별 진행률'**
  String get levelProgress;

  /// No description provided for @reviewAvailable.
  ///
  /// In ko, this message translates to:
  /// **'복습할 문제가 있어요!'**
  String get reviewAvailable;

  /// No description provided for @reviewWaiting.
  ///
  /// In ko, this message translates to:
  /// **'{count}개의 문제가 복습을 기다려요'**
  String reviewWaiting(int count);

  /// No description provided for @welcome.
  ///
  /// In ko, this message translates to:
  /// **'환영합니다!'**
  String get welcome;

  /// 온보딩에서 레벨 선택 안내
  ///
  /// In ko, this message translates to:
  /// **'목표 레벨을 선택하세요'**
  String get selectLevel;

  /// No description provided for @canChangeInSettings.
  ///
  /// In ko, this message translates to:
  /// **'나중에 설정에서 변경할 수 있어요'**
  String get canChangeInSettings;

  /// No description provided for @start.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get start;

  /// 목표 레벨 라벨
  ///
  /// In ko, this message translates to:
  /// **'목표 레벨'**
  String get levelTarget;

  /// A1 레벨명
  ///
  /// In ko, this message translates to:
  /// **'입문'**
  String get levelNameA1;

  /// A2 레벨명
  ///
  /// In ko, this message translates to:
  /// **'초급'**
  String get levelNameA2;

  /// B1 레벨명
  ///
  /// In ko, this message translates to:
  /// **'중급'**
  String get levelNameB1;

  /// B2 레벨명
  ///
  /// In ko, this message translates to:
  /// **'중상급'**
  String get levelNameB2;

  /// C1 레벨명
  ///
  /// In ko, this message translates to:
  /// **'상급'**
  String get levelNameC1;

  /// C2 레벨명
  ///
  /// In ko, this message translates to:
  /// **'최상급'**
  String get levelNameC2;

  /// No description provided for @grammar.
  ///
  /// In ko, this message translates to:
  /// **'문법'**
  String get grammar;

  /// No description provided for @vocabulary.
  ///
  /// In ko, this message translates to:
  /// **'어휘'**
  String get vocabulary;

  /// No description provided for @grammarAndVocabulary.
  ///
  /// In ko, this message translates to:
  /// **'문법 & 어휘'**
  String get grammarAndVocabulary;

  /// No description provided for @noWrongAnswers.
  ///
  /// In ko, this message translates to:
  /// **'틀린 문제가 없어요!'**
  String get noWrongAnswers;

  /// No description provided for @noWrongAnswersDesc.
  ///
  /// In ko, this message translates to:
  /// **'꾸준히 학습하며 실력을 쌓아가고 있네요.\n앞으로도 화이팅!'**
  String get noWrongAnswersDesc;

  /// No description provided for @wrongCount.
  ///
  /// In ko, this message translates to:
  /// **'{count}회 틀림'**
  String wrongCount(int count);

  /// No description provided for @correctAnswer.
  ///
  /// In ko, this message translates to:
  /// **'정답'**
  String get correctAnswer;

  /// No description provided for @yourAnswer.
  ///
  /// In ko, this message translates to:
  /// **'내가 고른 답'**
  String get yourAnswer;

  /// No description provided for @explanation.
  ///
  /// In ko, this message translates to:
  /// **'해설'**
  String get explanation;

  /// No description provided for @premium.
  ///
  /// In ko, this message translates to:
  /// **'프리미엄'**
  String get premium;

  /// No description provided for @removeAds.
  ///
  /// In ko, this message translates to:
  /// **'광고 제거'**
  String get removeAds;

  /// No description provided for @premiumActivated.
  ///
  /// In ko, this message translates to:
  /// **'프리미엄이 활성화되었습니다'**
  String get premiumActivated;

  /// No description provided for @purchase.
  ///
  /// In ko, this message translates to:
  /// **'구매'**
  String get purchase;

  /// No description provided for @restorePurchases.
  ///
  /// In ko, this message translates to:
  /// **'구매 복원'**
  String get restorePurchases;

  /// No description provided for @studyNotification.
  ///
  /// In ko, this message translates to:
  /// **'학습 알림'**
  String get studyNotification;

  /// No description provided for @dailyNotification.
  ///
  /// In ko, this message translates to:
  /// **'매일 정해진 시간에 알림'**
  String get dailyNotification;

  /// No description provided for @notificationOff.
  ///
  /// In ko, this message translates to:
  /// **'알림 꺼짐'**
  String get notificationOff;

  /// No description provided for @notificationTime.
  ///
  /// In ko, this message translates to:
  /// **'알림 시간'**
  String get notificationTime;

  /// No description provided for @notificationChannelName.
  ///
  /// In ko, this message translates to:
  /// **'학습 리마인더'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDesc.
  ///
  /// In ko, this message translates to:
  /// **'매일 학습 시간을 알려드립니다'**
  String get notificationChannelDesc;

  /// No description provided for @notificationTitle.
  ///
  /// In ko, this message translates to:
  /// **'쉬운 스페인어'**
  String get notificationTitle;

  /// No description provided for @notificationBody.
  ///
  /// In ko, this message translates to:
  /// **'오늘의 학습을 시작할 시간이에요!'**
  String get notificationBody;

  /// No description provided for @language.
  ///
  /// In ko, this message translates to:
  /// **'언어'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In ko, this message translates to:
  /// **'언어 선택'**
  String get selectLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In ko, this message translates to:
  /// **'시스템 설정'**
  String get languageSystem;

  /// No description provided for @soundAndVibration.
  ///
  /// In ko, this message translates to:
  /// **'사운드 및 진동'**
  String get soundAndVibration;

  /// No description provided for @soundEffects.
  ///
  /// In ko, this message translates to:
  /// **'효과음'**
  String get soundEffects;

  /// No description provided for @soundEffectsDesc.
  ///
  /// In ko, this message translates to:
  /// **'정답/오답 시 효과음 재생'**
  String get soundEffectsDesc;

  /// No description provided for @vibration.
  ///
  /// In ko, this message translates to:
  /// **'진동'**
  String get vibration;

  /// No description provided for @vibrationDesc.
  ///
  /// In ko, this message translates to:
  /// **'정답/오답 시 진동 피드백'**
  String get vibrationDesc;

  /// No description provided for @ttsSettings.
  ///
  /// In ko, this message translates to:
  /// **'TTS 설정'**
  String get ttsSettings;

  /// No description provided for @ttsAutoPlay.
  ///
  /// In ko, this message translates to:
  /// **'자동 재생'**
  String get ttsAutoPlay;

  /// No description provided for @ttsAutoPlayDesc.
  ///
  /// In ko, this message translates to:
  /// **'정답 확인 시 스페인어 자동 발음'**
  String get ttsAutoPlayDesc;

  /// No description provided for @showHint.
  ///
  /// In ko, this message translates to:
  /// **'힌트 보기'**
  String get showHint;

  /// No description provided for @nextQuestion.
  ///
  /// In ko, this message translates to:
  /// **'다음 문제'**
  String get nextQuestion;

  /// No description provided for @keyPoints.
  ///
  /// In ko, this message translates to:
  /// **'핵심 포인트'**
  String get keyPoints;

  /// No description provided for @theoryComplete.
  ///
  /// In ko, this message translates to:
  /// **'학습 완료'**
  String get theoryComplete;

  /// No description provided for @excellentComplete.
  ///
  /// In ko, this message translates to:
  /// **'훌륭해요!'**
  String get excellentComplete;

  /// No description provided for @goodComplete.
  ///
  /// In ko, this message translates to:
  /// **'잘했어요!'**
  String get goodComplete;

  /// No description provided for @phaseResults.
  ///
  /// In ko, this message translates to:
  /// **'단계별 결과'**
  String get phaseResults;

  /// No description provided for @additionalStudy.
  ///
  /// In ko, this message translates to:
  /// **'추가 학습하기'**
  String get additionalStudy;

  /// No description provided for @continueReviewWithCount.
  ///
  /// In ko, this message translates to:
  /// **'이어서 복습 ({count}개 남음)'**
  String continueReviewWithCount(int count);

  /// No description provided for @totalStudied.
  ///
  /// In ko, this message translates to:
  /// **'총 학습 문제'**
  String get totalStudied;

  /// No description provided for @accuracyRate.
  ///
  /// In ko, this message translates to:
  /// **'정답률'**
  String get accuracyRate;

  /// No description provided for @studyDays.
  ///
  /// In ko, this message translates to:
  /// **'학습 일수'**
  String get studyDays;

  /// No description provided for @studyTime.
  ///
  /// In ko, this message translates to:
  /// **'학습 시간'**
  String get studyTime;

  /// No description provided for @currentStreak.
  ///
  /// In ko, this message translates to:
  /// **'현재 연속 학습'**
  String get currentStreak;

  /// No description provided for @longestStreak.
  ///
  /// In ko, this message translates to:
  /// **'최장 연속 학습'**
  String get longestStreak;

  /// No description provided for @streakEncouragement.
  ///
  /// In ko, this message translates to:
  /// **'꾸준히 학습하면 실력이 쑥쑥 올라요!'**
  String get streakEncouragement;

  /// No description provided for @noStudyYet.
  ///
  /// In ko, this message translates to:
  /// **'아직 학습 기록이 없어요'**
  String get noStudyYet;

  /// No description provided for @daysUnit.
  ///
  /// In ko, this message translates to:
  /// **'{count}일'**
  String daysUnit(int count);

  /// No description provided for @minutes.
  ///
  /// In ko, this message translates to:
  /// **'{count}분'**
  String minutes(int count);

  /// No description provided for @selectDailyGoal.
  ///
  /// In ko, this message translates to:
  /// **'일일 학습량 선택'**
  String get selectDailyGoal;

  /// No description provided for @selectTargetLevel.
  ///
  /// In ko, this message translates to:
  /// **'목표 레벨 선택'**
  String get selectTargetLevel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'id',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'th',
    'vi',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
