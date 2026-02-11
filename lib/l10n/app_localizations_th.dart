// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'สเปนง่ายๆ';

  @override
  String get appFullTitle => 'สเปนง่ายๆ - ไวยากรณ์และคำศัพท์';

  @override
  String get home => 'หน้าหลัก';

  @override
  String get progress => 'ความคืบหน้า';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get wrongAnswers => 'ข้อผิดพลาด';

  @override
  String error(String message) {
    return 'ข้อผิดพลาด: $message';
  }

  @override
  String get startStudy => 'เริ่มเรียน';

  @override
  String get continueStudy => 'เรียนต่อ';

  @override
  String get startReview => 'ทบทวน';

  @override
  String get todayStudy => 'การเรียนวันนี้';

  @override
  String get allTopicsCompleted => 'เรียนครบทุกหัวข้อแล้ว!';

  @override
  String get reviewEncouragement => 'ทบทวนต่อเพื่อเชี่ยวชาญเนื้อหา';

  @override
  String get nextTopic => 'หัวข้อถัดไป';

  @override
  String questionsCount(int count) {
    return '$count ข้อ';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return 'ทำเสร็จ $count ข้อวันนี้';
  }

  @override
  String get todayGoal => 'เป้าหมายวันนี้';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal หัวข้อ';
  }

  @override
  String streakDays(int days) {
    return 'เรียนติดต่อกัน $days วัน!';
  }

  @override
  String get overallProgress => 'ความคืบหน้าโดยรวม';

  @override
  String get mastered => 'เชี่ยวชาญ';

  @override
  String get studiedOnce => 'เรียนแล้วอย่างน้อย 1 ครั้ง';

  @override
  String totalQuestions(int count) {
    return 'ทั้งหมด $count ข้อ';
  }

  @override
  String questionsMastered(int count, int total) {
    return 'เชี่ยวชาญ $count / $total ข้อ';
  }

  @override
  String get study => 'เรียน';

  @override
  String get notifications => 'การแจ้งเตือน';

  @override
  String get appSettings => 'ตั้งค่าแอป';

  @override
  String get info => 'ข้อมูล';

  @override
  String get appVersion => 'เวอร์ชันแอป';

  @override
  String get termsAndPolicies => 'เงื่อนไขและนโยบาย';

  @override
  String get termsOfService => 'เงื่อนไขการใช้งาน';

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get support => 'สนับสนุน';

  @override
  String get data => 'ข้อมูล';

  @override
  String get resetStudyRecords => 'รีเซ็ตบันทึกการเรียน';

  @override
  String get resetStudyRecordsDesc => 'ลบบันทึกการเรียนทั้งหมด';

  @override
  String get resetStudyRecordsConfirm =>
      'บันทึกการเรียนทั้งหมดจะถูกลบ\nไม่สามารถย้อนกลับได้';

  @override
  String get cannotOpenLink => 'ไม่สามารถเปิดลิงก์ได้';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get reset => 'รีเซ็ต';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get studyRecordsReset => 'รีเซ็ตบันทึกการเรียนแล้ว';

  @override
  String get dailyStudyAmount => 'ปริมาณการเรียนรายวัน';

  @override
  String topicsUnit(int count) {
    return '$count หัวข้อ';
  }

  @override
  String get customSetting => 'กำหนดเอง';

  @override
  String get theme => 'ธีม';

  @override
  String get selectTheme => 'เลือกธีม';

  @override
  String get themeSystem => 'ตามระบบ';

  @override
  String get themeLight => 'โหมดสว่าง';

  @override
  String get themeDark => 'โหมดมืด';

  @override
  String get studyComplete => 'เรียนเสร็จแล้ว';

  @override
  String get goodJob => 'ดีมาก!';

  @override
  String get goHome => 'กลับหน้าหลัก';

  @override
  String get accuracy => 'ความแม่นยำ';

  @override
  String get correct => 'ถูก';

  @override
  String get wrong => 'ผิด';

  @override
  String get timeSpent => 'เวลาที่ใช้';

  @override
  String get wrongReview => 'ทบทวนข้อผิด';

  @override
  String get spacedReview => 'ทบทวนแบบเว้นระยะ';

  @override
  String get newLearning => 'เรียนรู้ใหม่';

  @override
  String get errorOccurred => 'เกิดข้อผิดพลาด';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get stopStudy => 'หยุดเรียน';

  @override
  String get stopStudyConfirm =>
      'ต้องการหยุดเรียนหรือไม่?\nความคืบหน้าจะถูกบันทึก';

  @override
  String get continueStudyButton => 'เรียนต่อ';

  @override
  String get stop => 'หยุด';

  @override
  String get levelProgress => 'ความคืบหน้าตามระดับ';

  @override
  String get reviewAvailable => 'มีข้อที่ต้องทบทวน!';

  @override
  String reviewWaiting(int count) {
    return '$count ข้อรอทบทวน';
  }

  @override
  String get welcome => 'ยินดีต้อนรับ!';

  @override
  String get selectLevel => 'เลือกระดับเป้าหมาย';

  @override
  String get canChangeInSettings => 'เปลี่ยนได้ภายหลังในตั้งค่า';

  @override
  String get start => 'เริ่มต้น';

  @override
  String get levelTarget => 'ระดับเป้าหมาย';

  @override
  String get levelNameA1 => 'เริ่มต้น';

  @override
  String get levelNameA2 => 'พื้นฐาน';

  @override
  String get levelNameB1 => 'กลาง';

  @override
  String get levelNameB2 => 'กลาง-สูง';

  @override
  String get levelNameC1 => 'สูง';

  @override
  String get levelNameC2 => 'เชี่ยวชาญ';

  @override
  String get grammar => 'ไวยากรณ์';

  @override
  String get vocabulary => 'คำศัพท์';

  @override
  String get grammarAndVocabulary => 'ไวยากรณ์และคำศัพท์';

  @override
  String get noWrongAnswers => 'ไม่มีข้อผิด!';

  @override
  String get noWrongAnswersDesc => 'คุณทำได้ดีมาก!\nเก่งมาก สู้ต่อไป!';

  @override
  String wrongCount(int count) {
    return 'ผิด $count ครั้ง';
  }

  @override
  String get correctAnswer => 'คำตอบที่ถูก';

  @override
  String get yourAnswer => 'คำตอบของคุณ';

  @override
  String get explanation => 'คำอธิบาย';

  @override
  String get premium => 'พรีเมียม';

  @override
  String get removeAds => 'ลบโฆษณา';

  @override
  String get premiumActivated => 'เปิดใช้งานพรีเมียมแล้ว';

  @override
  String get purchase => 'ซื้อ';

  @override
  String get restorePurchases => 'กู้คืนการซื้อ';

  @override
  String get studyNotification => 'แจ้งเตือนการเรียน';

  @override
  String get dailyNotification => 'แจ้งเตือนรายวันตามเวลาที่ตั้ง';

  @override
  String get notificationOff => 'ปิดการแจ้งเตือน';

  @override
  String get notificationTime => 'เวลาแจ้งเตือน';

  @override
  String get notificationChannelName => 'แจ้งเตือนการเรียน';

  @override
  String get notificationChannelDesc => 'แจ้งเตือนเวลาเรียนรายวัน';

  @override
  String get notificationTitle => 'สเปนง่ายๆ';

  @override
  String get notificationBody => 'ถึงเวลาเริ่มเรียนแล้ว!';

  @override
  String get language => 'ภาษา';

  @override
  String get selectLanguage => 'เลือกภาษา';

  @override
  String get languageSystem => 'ตามระบบ';

  @override
  String get soundAndVibration => 'เสียงและการสั่น';

  @override
  String get soundEffects => 'เอฟเฟกต์เสียง';

  @override
  String get soundEffectsDesc => 'เล่นเสียงเมื่อตอบถูก/ผิด';

  @override
  String get vibration => 'การสั่น';

  @override
  String get vibrationDesc => 'สั่นเมื่อตอบถูก/ผิด';

  @override
  String get ttsSettings => 'ตั้งค่าเสียง';

  @override
  String get ttsAutoPlay => 'เล่นอัตโนมัติ';

  @override
  String get ttsAutoPlayDesc => 'ออกเสียงสเปนอัตโนมัติเมื่อตอบถูก';

  @override
  String get ttsSpeechRate => 'ความเร็ว';

  @override
  String get ttsVoice => 'เสียง';

  @override
  String get ttsVoiceDefault => 'ค่าเริ่มต้น';

  @override
  String get ttsSpeedSlow => 'ช้า';

  @override
  String get ttsSpeedNormal => 'ปกติ';

  @override
  String get ttsSpeedFast => 'เร็ว';

  @override
  String get ttsTestPlay => 'ฟังตัวอย่าง';

  @override
  String get showHint => 'ดูคำใบ้';

  @override
  String get nextQuestion => 'คำถามถัดไป';

  @override
  String get keyPoints => 'ประเด็นสำคัญ';

  @override
  String get theoryComplete => 'เสร็จสิ้น';

  @override
  String get excellentComplete => 'ยอดเยี่ยม!';

  @override
  String get goodComplete => 'ทำได้ดี!';

  @override
  String get phaseResults => 'ผลลัพธ์ตามขั้นตอน';

  @override
  String get additionalStudy => 'เรียนต่อ';

  @override
  String continueReviewWithCount(int count) {
    return 'ทบทวนต่อ (เหลือ $count ข้อ)';
  }

  @override
  String get totalStudied => 'เรียนทั้งหมด';

  @override
  String get accuracyRate => 'อัตราความถูกต้อง';

  @override
  String get studyDays => 'จำนวนวันเรียน';

  @override
  String get studyTime => 'เวลาเรียน';

  @override
  String get currentStreak => 'เรียนต่อเนื่องปัจจุบัน';

  @override
  String get longestStreak => 'เรียนต่อเนื่องสูงสุด';

  @override
  String get streakEncouragement => 'เรียนต่อเนื่องเพื่อพัฒนาทักษะ!';

  @override
  String get noStudyYet => 'ยังไม่มีบันทึกการเรียน';

  @override
  String daysUnit(int count) {
    return '$count วัน';
  }

  @override
  String minutes(int count) {
    return '$count นาที';
  }

  @override
  String get selectDailyGoal => 'เลือกเป้าหมายรายวัน';

  @override
  String get selectTargetLevel => 'เลือกระดับเป้าหมาย';
}
