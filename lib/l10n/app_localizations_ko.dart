// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '쉬운 스페인어';

  @override
  String get appFullTitle => '쉬운 스페인어 - 문법 & 단어';

  @override
  String get home => '홈';

  @override
  String get progress => '진행률';

  @override
  String get settings => '설정';

  @override
  String get wrongAnswers => '오답노트';

  @override
  String error(String message) {
    return '오류: $message';
  }

  @override
  String get startStudy => '학습 시작하기';

  @override
  String get continueStudy => '학습 이어하기';

  @override
  String get startReview => '복습하기';

  @override
  String get todayStudy => '오늘의 학습';

  @override
  String get allTopicsCompleted => '모든 주제 학습 완료!';

  @override
  String get reviewEncouragement => '복습을 통해 실력을 더욱 쌓아보세요.';

  @override
  String get nextTopic => '다음 주제';

  @override
  String questionsCount(int count) {
    return '$count문제';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '오늘 $count문제 학습 완료';
  }

  @override
  String get todayGoal => '오늘의 목표';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal 주제';
  }

  @override
  String streakDays(int days) {
    return '연속 $days일째 학습 중!';
  }

  @override
  String get overallProgress => '전체 진행률';

  @override
  String get mastered => '완전 습득';

  @override
  String get studiedOnce => '1회 이상 학습';

  @override
  String totalQuestions(int count) {
    return '총 $count문제';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total 문제 완전 습득';
  }

  @override
  String get study => '학습';

  @override
  String get notifications => '알림';

  @override
  String get appSettings => '앱 설정';

  @override
  String get info => '정보';

  @override
  String get appVersion => '앱 버전';

  @override
  String get termsAndPolicies => '약관 및 정책';

  @override
  String get termsOfService => '이용약관';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get support => '고객 지원';

  @override
  String get data => '데이터';

  @override
  String get resetStudyRecords => '학습 기록 초기화';

  @override
  String get resetStudyRecordsDesc => '모든 학습 기록을 삭제합니다';

  @override
  String get resetStudyRecordsConfirm => '모든 학습 기록이 삭제됩니다.\n이 작업은 되돌릴 수 없습니다.';

  @override
  String get cannotOpenLink => '링크를 열 수 없습니다.';

  @override
  String get cancel => '취소';

  @override
  String get reset => '초기화';

  @override
  String get confirm => '확인';

  @override
  String get studyRecordsReset => '학습 기록이 초기화되었습니다.';

  @override
  String get dailyStudyAmount => '일일 학습량';

  @override
  String topicsUnit(int count) {
    return '$count주제';
  }

  @override
  String get customSetting => '직접 설정';

  @override
  String get theme => '테마';

  @override
  String get selectTheme => '테마 선택';

  @override
  String get themeSystem => '시스템 설정';

  @override
  String get themeLight => '라이트 모드';

  @override
  String get themeDark => '다크 모드';

  @override
  String get studyComplete => '학습 완료';

  @override
  String get goodJob => '수고하셨습니다';

  @override
  String get goHome => '홈으로';

  @override
  String get accuracy => '정답률';

  @override
  String get correct => '정답';

  @override
  String get wrong => '오답';

  @override
  String get timeSpent => '소요 시간';

  @override
  String get wrongReview => '오답 복습';

  @override
  String get spacedReview => '망각곡선 복습';

  @override
  String get newLearning => '신규 학습';

  @override
  String get errorOccurred => '오류가 발생했습니다';

  @override
  String get retry => '다시 시도';

  @override
  String get stopStudy => '학습 중단';

  @override
  String get stopStudyConfirm => '학습을 중단하시겠습니까?\n현재까지의 진행 상황은 저장됩니다.';

  @override
  String get continueStudyButton => '계속 학습';

  @override
  String get stop => '중단';

  @override
  String get levelProgress => '레벨별 진행률';

  @override
  String get reviewAvailable => '복습할 문제가 있어요!';

  @override
  String reviewWaiting(int count) {
    return '$count개의 문제가 복습을 기다려요';
  }

  @override
  String get welcome => '환영합니다!';

  @override
  String get selectLevel => '목표 레벨을 선택하세요';

  @override
  String get canChangeInSettings => '나중에 설정에서 변경할 수 있어요';

  @override
  String get start => '시작하기';

  @override
  String get levelTarget => '목표 레벨';

  @override
  String get levelNameA1 => '입문';

  @override
  String get levelNameA2 => '초급';

  @override
  String get levelNameB1 => '중급';

  @override
  String get levelNameB2 => '중상급';

  @override
  String get levelNameC1 => '상급';

  @override
  String get levelNameC2 => '최상급';

  @override
  String get grammar => '문법';

  @override
  String get vocabulary => '어휘';

  @override
  String get grammarAndVocabulary => '문법 & 어휘';

  @override
  String get noWrongAnswers => '틀린 문제가 없어요!';

  @override
  String get noWrongAnswersDesc => '꾸준히 학습하며 실력을 쌓아가고 있네요.\n앞으로도 화이팅!';

  @override
  String wrongCount(int count) {
    return '$count회 틀림';
  }

  @override
  String get correctAnswer => '정답';

  @override
  String get yourAnswer => '내가 고른 답';

  @override
  String get explanation => '해설';

  @override
  String get premium => '프리미엄';

  @override
  String get removeAds => '광고 제거';

  @override
  String get premiumActivated => '프리미엄이 활성화되었습니다';

  @override
  String get purchase => '구매';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get purchaseFailed => '구매에 실패했습니다';

  @override
  String get purchasesRestored => '구매가 복원되었습니다';

  @override
  String get productNotAvailable => '상품을 불러올 수 없습니다';

  @override
  String get studyNotification => '학습 알림';

  @override
  String get dailyNotification => '하루 이상 접속하지 않으면 학습 알림';

  @override
  String get notificationOff => '알림 꺼짐';

  @override
  String get notificationTime => '알림 시간';

  @override
  String get notificationChannelName => '학습 리마인더';

  @override
  String get notificationChannelDesc => '매일 학습 시간을 알려드립니다';

  @override
  String get notificationTitle => '쉬운 스페인어';

  @override
  String get notificationBody => '오늘의 학습을 시작할 시간이에요!';

  @override
  String get language => '언어';

  @override
  String get selectLanguage => '언어 선택';

  @override
  String get languageSystem => '시스템 설정';

  @override
  String get soundAndVibration => '사운드 및 진동';

  @override
  String get soundEffects => '효과음';

  @override
  String get soundEffectsDesc => '정답/오답 시 효과음 재생';

  @override
  String get vibration => '진동';

  @override
  String get vibrationDesc => '정답/오답 시 진동 피드백';

  @override
  String get ttsSettings => '음성 설정';

  @override
  String get ttsAutoPlay => '자동 재생';

  @override
  String get ttsAutoPlayDesc => '정답 확인 시 스페인어 자동 발음';

  @override
  String get ttsSpeechRate => '재생 속도';

  @override
  String get ttsVoice => '음성 선택';

  @override
  String get ttsVoiceDefault => '기본 음성';

  @override
  String get ttsSpeedSlow => '느리게';

  @override
  String get ttsSpeedNormal => '보통';

  @override
  String get ttsSpeedFast => '빠르게';

  @override
  String get ttsTestPlay => '미리 듣기';

  @override
  String get showHint => '힌트 보기';

  @override
  String get nextQuestion => '다음 문제';

  @override
  String get keyPoints => '핵심 포인트';

  @override
  String get theoryComplete => '학습 완료';

  @override
  String get excellentComplete => '훌륭해요!';

  @override
  String get goodComplete => '잘했어요!';

  @override
  String get phaseResults => '단계별 결과';

  @override
  String get additionalStudy => '추가 학습하기';

  @override
  String continueReviewWithCount(int count) {
    return '이어서 복습 ($count개 남음)';
  }

  @override
  String get totalStudied => '총 학습 문제';

  @override
  String get accuracyRate => '정답률';

  @override
  String get studyDays => '학습 일수';

  @override
  String get studyTime => '학습 시간';

  @override
  String get currentStreak => '현재 연속 학습';

  @override
  String get longestStreak => '최장 연속 학습';

  @override
  String get streakEncouragement => '꾸준히 학습하면 실력이 쑥쑥 올라요!';

  @override
  String get noStudyYet => '아직 학습 기록이 없어요';

  @override
  String daysUnit(int count) {
    return '$count일';
  }

  @override
  String minutes(int count) {
    return '$count분';
  }

  @override
  String get selectDailyGoal => '일일 학습량 선택';

  @override
  String get selectTargetLevel => '목표 레벨 선택';

  @override
  String get notificationMsg1 => '스페인어 실력이 기다리고 있어요! 오늘도 한 걸음 나아가볼까요?';

  @override
  String get notificationMsg2 => '어제 배운 내용, 기억나시나요? 복습하면 더 오래 기억돼요!';

  @override
  String get notificationMsg3 => '매일 조금씩, 꾸준히! 오늘의 스페인어 학습을 시작해보세요.';

  @override
  String get notificationMsg4 => '¡Hola! 스페인어가 보고 싶었어요. 오늘도 함께 공부해요!';

  @override
  String get notificationMsg5 => '학습 연속 기록이 끊기기 전에! 지금 바로 시작해볼까요?';
}
