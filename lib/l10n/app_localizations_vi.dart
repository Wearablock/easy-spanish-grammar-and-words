// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Học Tây Ban Nha';

  @override
  String get appFullTitle => 'Học Tây Ban Nha - Ngữ Pháp';

  @override
  String get home => 'Trang chủ';

  @override
  String get progress => 'Tiến trình';

  @override
  String get settings => 'Cài đặt';

  @override
  String get wrongAnswers => 'Câu sai';

  @override
  String error(String message) {
    return 'Lỗi: $message';
  }

  @override
  String get startStudy => 'Bắt đầu học';

  @override
  String get continueStudy => 'Tiếp tục học';

  @override
  String get startReview => 'Ôn tập';

  @override
  String get todayStudy => 'Học hôm nay';

  @override
  String get allTopicsCompleted => 'Đã hoàn thành tất cả chủ đề!';

  @override
  String get reviewEncouragement => 'Tiếp tục ôn tập để nắm vững nội dung.';

  @override
  String get nextTopic => 'Chủ đề tiếp theo';

  @override
  String questionsCount(int count) {
    return '$count câu';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return 'Đã hoàn thành $count câu hôm nay';
  }

  @override
  String get todayGoal => 'Mục tiêu hôm nay';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal chủ đề';
  }

  @override
  String streakDays(int days) {
    return 'Học liên tục $days ngày!';
  }

  @override
  String get overallProgress => 'Tiến trình chung';

  @override
  String get mastered => 'Đã thành thạo';

  @override
  String get studiedOnce => 'Đã học ít nhất 1 lần';

  @override
  String totalQuestions(int count) {
    return 'Tổng $count câu';
  }

  @override
  String questionsMastered(int count, int total) {
    return 'Thành thạo $count / $total câu';
  }

  @override
  String get study => 'Học';

  @override
  String get notifications => 'Thông báo';

  @override
  String get appSettings => 'Cài đặt ứng dụng';

  @override
  String get info => 'Thông tin';

  @override
  String get appVersion => 'Phiên bản';

  @override
  String get termsAndPolicies => 'Điều khoản & chính sách';

  @override
  String get termsOfService => 'Điều khoản sử dụng';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get support => 'Hỗ trợ';

  @override
  String get data => 'Dữ liệu';

  @override
  String get resetStudyRecords => 'Đặt lại dữ liệu học';

  @override
  String get resetStudyRecordsDesc => 'Xóa tất cả dữ liệu học';

  @override
  String get resetStudyRecordsConfirm =>
      'Tất cả dữ liệu học sẽ bị xóa.\nKhông thể hoàn tác.';

  @override
  String get cannotOpenLink => 'Không thể mở liên kết.';

  @override
  String get cancel => 'Hủy';

  @override
  String get reset => 'Đặt lại';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get studyRecordsReset => 'Đã đặt lại dữ liệu học.';

  @override
  String get dailyStudyAmount => 'Lượng học hàng ngày';

  @override
  String topicsUnit(int count) {
    return '$count chủ đề';
  }

  @override
  String get customSetting => 'Tùy chỉnh';

  @override
  String get theme => 'Giao diện';

  @override
  String get selectTheme => 'Chọn giao diện';

  @override
  String get themeSystem => 'Theo hệ thống';

  @override
  String get themeLight => 'Chế độ sáng';

  @override
  String get themeDark => 'Chế độ tối';

  @override
  String get studyComplete => 'Hoàn thành học';

  @override
  String get goodJob => 'Tốt lắm!';

  @override
  String get goHome => 'Trang chủ';

  @override
  String get accuracy => 'Độ chính xác';

  @override
  String get correct => 'Đúng';

  @override
  String get wrong => 'Sai';

  @override
  String get timeSpent => 'Thời gian';

  @override
  String get wrongReview => 'Ôn lại câu sai';

  @override
  String get spacedReview => 'Ôn tập giãn cách';

  @override
  String get newLearning => 'Học mới';

  @override
  String get errorOccurred => 'Đã xảy ra lỗi';

  @override
  String get retry => 'Thử lại';

  @override
  String get stopStudy => 'Dừng học';

  @override
  String get stopStudyConfirm => 'Bạn muốn dừng học?\nTiến trình sẽ được lưu.';

  @override
  String get continueStudyButton => 'Tiếp tục';

  @override
  String get stop => 'Dừng';

  @override
  String get levelProgress => 'Tiến trình theo cấp độ';

  @override
  String get reviewAvailable => 'Có câu cần ôn tập!';

  @override
  String reviewWaiting(int count) {
    return '$count câu đang chờ ôn tập';
  }

  @override
  String get welcome => 'Chào mừng!';

  @override
  String get selectLevel => 'Chọn cấp độ mục tiêu';

  @override
  String get canChangeInSettings => 'Có thể thay đổi sau trong cài đặt';

  @override
  String get start => 'Bắt đầu';

  @override
  String get levelTarget => 'Cấp độ mục tiêu';

  @override
  String get levelNameA1 => 'Sơ cấp';

  @override
  String get levelNameA2 => 'Cơ bản';

  @override
  String get levelNameB1 => 'Trung cấp';

  @override
  String get levelNameB2 => 'Trung cấp cao';

  @override
  String get levelNameC1 => 'Cao cấp';

  @override
  String get levelNameC2 => 'Thành thạo';

  @override
  String get grammar => 'Ngữ pháp';

  @override
  String get vocabulary => 'Từ vựng';

  @override
  String get grammarAndVocabulary => 'Ngữ pháp & Từ vựng';

  @override
  String get noWrongAnswers => 'Không có câu sai!';

  @override
  String get noWrongAnswersDesc =>
      'Bạn đang làm rất tốt!\nHãy tiếp tục phát huy!';

  @override
  String wrongCount(int count) {
    return 'Sai $count lần';
  }

  @override
  String get correctAnswer => 'Đáp án đúng';

  @override
  String get yourAnswer => 'Câu trả lời của bạn';

  @override
  String get explanation => 'Giải thích';

  @override
  String get premium => 'Premium';

  @override
  String get removeAds => 'Xóa quảng cáo';

  @override
  String get premiumActivated => 'Đã kích hoạt Premium';

  @override
  String get purchase => 'Mua';

  @override
  String get restorePurchases => 'Khôi phục mua hàng';

  @override
  String get purchaseFailed => 'Mua hàng thất bại';

  @override
  String get purchasesRestored => 'Đã khôi phục giao dịch mua';

  @override
  String get productNotAvailable => 'Không thể tải sản phẩm';

  @override
  String get studyNotification => 'Nhắc nhở học';

  @override
  String get dailyNotification =>
      'Nhắc nhở học tập khi không truy cập hơn 1 ngày';

  @override
  String get notificationOff => 'Tắt thông báo';

  @override
  String get notificationTime => 'Thời gian thông báo';

  @override
  String get notificationChannelName => 'Nhắc nhở học';

  @override
  String get notificationChannelDesc => 'Nhắc nhở học hàng ngày';

  @override
  String get notificationTitle => 'Học Tây Ban Nha';

  @override
  String get notificationBody => 'Đến giờ bắt đầu học rồi!';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get selectLanguage => 'Chọn ngôn ngữ';

  @override
  String get languageSystem => 'Theo hệ thống';

  @override
  String get soundAndVibration => 'Âm thanh & rung';

  @override
  String get soundEffects => 'Hiệu ứng âm thanh';

  @override
  String get soundEffectsDesc => 'Phát âm thanh khi đúng/sai';

  @override
  String get vibration => 'Rung';

  @override
  String get vibrationDesc => 'Rung khi đúng/sai';

  @override
  String get ttsSettings => 'Cài đặt giọng nói';

  @override
  String get ttsAutoPlay => 'Tự động phát';

  @override
  String get ttsAutoPlayDesc => 'Tự động phát âm tiếng Tây Ban Nha khi đúng';

  @override
  String get ttsSpeechRate => 'Tốc độ';

  @override
  String get ttsVoice => 'Giọng nói';

  @override
  String get ttsVoiceDefault => 'Mặc định';

  @override
  String get ttsSpeedSlow => 'Chậm';

  @override
  String get ttsSpeedNormal => 'Bình thường';

  @override
  String get ttsSpeedFast => 'Nhanh';

  @override
  String get ttsTestPlay => 'Nghe thử';

  @override
  String get showHint => 'Xem gợi ý';

  @override
  String get nextQuestion => 'Câu tiếp theo';

  @override
  String get keyPoints => 'Điểm chính';

  @override
  String get theoryComplete => 'Hoàn thành';

  @override
  String get excellentComplete => 'Xuất sắc!';

  @override
  String get goodComplete => 'Làm tốt lắm!';

  @override
  String get phaseResults => 'Kết quả theo giai đoạn';

  @override
  String get additionalStudy => 'Học thêm';

  @override
  String continueReviewWithCount(int count) {
    return 'Tiếp tục ôn tập (còn $count câu)';
  }

  @override
  String get totalStudied => 'Tổng đã học';

  @override
  String get accuracyRate => 'Tỉ lệ đúng';

  @override
  String get studyDays => 'Số ngày học';

  @override
  String get studyTime => 'Thời gian học';

  @override
  String get currentStreak => 'Chuỗi hiện tại';

  @override
  String get longestStreak => 'Chuỗi dài nhất';

  @override
  String get streakEncouragement => 'Tiếp tục học để tiến bộ!';

  @override
  String get noStudyYet => 'Chưa có dữ liệu học';

  @override
  String daysUnit(int count) {
    return '$count ngày';
  }

  @override
  String minutes(int count) {
    return '$count phút';
  }

  @override
  String get selectDailyGoal => 'Chọn mục tiêu hàng ngày';

  @override
  String get selectTargetLevel => 'Chọn cấp độ mục tiêu';

  @override
  String get notificationMsg1 =>
      'Tiếng Tây Ban Nha đang chờ bạn! Sẵn sàng tiến thêm một bước hôm nay?';

  @override
  String get notificationMsg2 =>
      'Bạn còn nhớ bài học hôm qua không? Ôn tập giúp nhớ lâu hơn!';

  @override
  String get notificationMsg3 =>
      'Mỗi ngày một chút! Bắt đầu bài học tiếng Tây Ban Nha hôm nay.';

  @override
  String get notificationMsg4 =>
      '¡Hola! Chúng tôi nhớ bạn. Hãy cùng học tiếng Tây Ban Nha hôm nay!';

  @override
  String get notificationMsg5 =>
      'Đừng để chuỗi ngày học bị gián đoạn! Bắt đầu ngay bây giờ.';

  @override
  String get howManyTopics => 'Mỗi ngày học bao nhiêu chủ đề?';

  @override
  String get oneTopic => '1 chủ đề';

  @override
  String get twoTopics => '2 chủ đề';

  @override
  String get threeTopics => '3 chủ đề';

  @override
  String get lightStart => 'Bắt đầu nhẹ nhàng';

  @override
  String get moderateAmount => 'Lượng vừa phải';

  @override
  String get intensiveStudy => 'Học tập chuyên sâu';

  @override
  String get topicList => 'Danh sách chủ đề';

  @override
  String get notStudiedYet => 'Chưa học';

  @override
  String get studiedLabel => 'Đã học';

  @override
  String topicCount(int count) {
    return '$count chủ đề';
  }

  @override
  String get speakingPractice => 'Luyện Nói';

  @override
  String get speakingTest => 'Kiểm Tra Nói';

  @override
  String get speakingBrowseAll => 'Xem tất cả';

  @override
  String get speakingFeatureDesc =>
      'Luyện và kiểm tra hàng chục biến thể từ một câu: đổi chủ ngữ, phủ định, câu hỏi, đổi từ.';

  @override
  String get practice => 'Luyện';

  @override
  String get test => 'Kiểm tra';

  @override
  String cardsCount(int count) {
    return '$count thẻ';
  }

  @override
  String loadFailedError(String error) {
    return 'Tải thất bại: $error';
  }

  @override
  String get noSeeds => 'Chưa có câu mẫu.';

  @override
  String get showMeaning => 'Xem nghĩa';

  @override
  String get speakAgain => 'Nói lại';

  @override
  String get nextCard => 'Tiếp';

  @override
  String get viewResult => 'Xem kết quả';

  @override
  String get listening => 'Đang nghe…';

  @override
  String get tapMicToSpeak => 'Chạm micro và nhắc lại';

  @override
  String get iSaid => 'Bạn đã nói';

  @override
  String get correctAnswerLabel => 'Đáp án';

  @override
  String get micPermissionRequired =>
      'Cần cấp quyền micro và nhận diện giọng nói. Vui lòng bật trong Cài đặt.';

  @override
  String speechError(String error) {
    return 'Lỗi nhận diện giọng nói: $error';
  }

  @override
  String get practiceResult => 'Kết quả luyện';

  @override
  String get testResult => 'Kết quả kiểm tra';

  @override
  String passedOfTotal(int passed, int total) {
    return '$passed / $total đạt';
  }

  @override
  String averageAccuracy(String percent) {
    return 'Độ chính xác trung bình $percent';
  }

  @override
  String get testPassed => '🎉 Đạt!';

  @override
  String get testFailed => 'Suýt rồi. Thử lại nhé!';

  @override
  String get sayInSpanishHint => 'Xem và nói bằng tiếng Tây Ban Nha';

  @override
  String get variationBase => 'Câu gốc';

  @override
  String variationSubject(String subject) {
    return 'Chủ ngữ · $subject';
  }

  @override
  String get variationNegative => 'Phủ định';

  @override
  String get variationInterrogative => 'Câu hỏi';

  @override
  String variationNounSwap(String noun) {
    return 'Đổi từ · $noun';
  }

  @override
  String get variationPhrase => 'Cách diễn đạt';

  @override
  String get feedbackPerfect => 'Tuyệt vời! 🎉';

  @override
  String get feedbackGreat => 'Rất tốt! 👏';

  @override
  String get feedbackGood => 'Khá. Thêm lần nữa!';

  @override
  String get feedbackKeepPractice => 'Cứ luyện tập tiếp.';

  @override
  String get feedbackTryAgain => 'Thử lại.';

  @override
  String get openSettings => 'Mở Cài đặt';

  @override
  String attemptCounter(int current, int total) {
    return 'Lần $current/$total';
  }

  @override
  String get playHint => 'Gợi ý phát âm';

  @override
  String get speakingReview => 'Ôn tập Nói';

  @override
  String speakingReviewDue(int count) {
    return '$count thẻ chờ ôn tập';
  }

  @override
  String get noReviewDue => 'Không có thẻ nào để ôn.\nHẹn gặp lại!';
}
