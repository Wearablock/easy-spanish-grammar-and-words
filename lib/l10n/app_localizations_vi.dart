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
  String get goHome => 'Về trang chủ';

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
  String get studyNotification => 'Nhắc nhở học';

  @override
  String get dailyNotification => 'Nhắc nhở hàng ngày theo giờ đã đặt';

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
}
