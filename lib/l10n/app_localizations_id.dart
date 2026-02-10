// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Spanyol Mudah';

  @override
  String get appFullTitle => 'Spanyol Mudah - Tata Bahasa';

  @override
  String get home => 'Beranda';

  @override
  String get progress => 'Progres';

  @override
  String get settings => 'Pengaturan';

  @override
  String get wrongAnswers => 'Jawaban Salah';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get startStudy => 'Mulai belajar';

  @override
  String get continueStudy => 'Lanjutkan belajar';

  @override
  String get startReview => 'Ulang';

  @override
  String get todayStudy => 'Belajar hari ini';

  @override
  String get allTopicsCompleted => 'Semua topik selesai!';

  @override
  String get reviewEncouragement => 'Terus mengulang untuk menguasai materi.';

  @override
  String get nextTopic => 'Topik selanjutnya';

  @override
  String questionsCount(int count) {
    return '$count soal';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '$count soal selesai hari ini';
  }

  @override
  String get todayGoal => 'Target hari ini';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal topik';
  }

  @override
  String streakDays(int days) {
    return '$days hari berturut-turut!';
  }

  @override
  String get overallProgress => 'Progres keseluruhan';

  @override
  String get mastered => 'Dikuasai';

  @override
  String get studiedOnce => 'Dipelajari setidaknya sekali';

  @override
  String totalQuestions(int count) {
    return 'Total $count soal';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total soal dikuasai';
  }

  @override
  String get study => 'Belajar';

  @override
  String get notifications => 'Notifikasi';

  @override
  String get appSettings => 'Pengaturan aplikasi';

  @override
  String get info => 'Informasi';

  @override
  String get appVersion => 'Versi aplikasi';

  @override
  String get termsAndPolicies => 'Syarat & kebijakan';

  @override
  String get termsOfService => 'Syarat layanan';

  @override
  String get privacyPolicy => 'Kebijakan privasi';

  @override
  String get support => 'Dukungan';

  @override
  String get data => 'Data';

  @override
  String get resetStudyRecords => 'Reset data belajar';

  @override
  String get resetStudyRecordsDesc => 'Hapus semua data belajar';

  @override
  String get resetStudyRecordsConfirm =>
      'Semua data belajar akan dihapus.\nTindakan ini tidak dapat dibatalkan.';

  @override
  String get cannotOpenLink => 'Tidak dapat membuka tautan.';

  @override
  String get cancel => 'Batal';

  @override
  String get reset => 'Reset';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get studyRecordsReset => 'Data belajar telah direset.';

  @override
  String get dailyStudyAmount => 'Jumlah belajar harian';

  @override
  String topicsUnit(int count) {
    return '$count topik';
  }

  @override
  String get customSetting => 'Kustom';

  @override
  String get theme => 'Tema';

  @override
  String get selectTheme => 'Pilih tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Mode terang';

  @override
  String get themeDark => 'Mode gelap';

  @override
  String get studyComplete => 'Belajar selesai';

  @override
  String get goodJob => 'Kerja bagus!';

  @override
  String get goHome => 'Ke beranda';

  @override
  String get accuracy => 'Akurasi';

  @override
  String get correct => 'Benar';

  @override
  String get wrong => 'Salah';

  @override
  String get timeSpent => 'Waktu';

  @override
  String get wrongReview => 'Ulang jawaban salah';

  @override
  String get spacedReview => 'Ulang berjarak';

  @override
  String get newLearning => 'Belajar baru';

  @override
  String get errorOccurred => 'Terjadi kesalahan';

  @override
  String get retry => 'Coba lagi';

  @override
  String get stopStudy => 'Hentikan belajar';

  @override
  String get stopStudyConfirm =>
      'Ingin menghentikan belajar?\nProgres akan disimpan.';

  @override
  String get continueStudyButton => 'Lanjutkan';

  @override
  String get stop => 'Hentikan';

  @override
  String get levelProgress => 'Progres per level';

  @override
  String get reviewAvailable => 'Ada soal yang perlu diulang!';

  @override
  String reviewWaiting(int count) {
    return '$count soal menunggu pengulangan';
  }

  @override
  String get welcome => 'Selamat datang!';

  @override
  String get selectLevel => 'Pilih level target';

  @override
  String get canChangeInSettings => 'Bisa diubah nanti di pengaturan';

  @override
  String get start => 'Mulai';

  @override
  String get levelTarget => 'Level target';

  @override
  String get levelNameA1 => 'Pemula';

  @override
  String get levelNameA2 => 'Dasar';

  @override
  String get levelNameB1 => 'Menengah';

  @override
  String get levelNameB2 => 'Menengah atas';

  @override
  String get levelNameC1 => 'Mahir';

  @override
  String get levelNameC2 => 'Penguasaan';

  @override
  String get grammar => 'Tata bahasa';

  @override
  String get vocabulary => 'Kosakata';

  @override
  String get grammarAndVocabulary => 'Tata bahasa & Kosakata';

  @override
  String get noWrongAnswers => 'Tidak ada jawaban salah!';

  @override
  String get noWrongAnswersDesc => 'Kamu hebat!\nTerus semangat!';

  @override
  String wrongCount(int count) {
    return 'Salah $count kali';
  }

  @override
  String get correctAnswer => 'Jawaban benar';

  @override
  String get yourAnswer => 'Jawabanmu';

  @override
  String get explanation => 'Penjelasan';

  @override
  String get premium => 'Premium';

  @override
  String get removeAds => 'Hapus iklan';

  @override
  String get premiumActivated => 'Premium diaktifkan';

  @override
  String get purchase => 'Beli';

  @override
  String get restorePurchases => 'Pulihkan pembelian';

  @override
  String get studyNotification => 'Pengingat belajar';

  @override
  String get dailyNotification => 'Pengingat harian pada waktu yang ditentukan';

  @override
  String get notificationOff => 'Notifikasi mati';

  @override
  String get notificationTime => 'Waktu notifikasi';

  @override
  String get notificationChannelName => 'Pengingat belajar';

  @override
  String get notificationChannelDesc => 'Pengingat belajar harian';

  @override
  String get notificationTitle => 'Spanyol Mudah';

  @override
  String get notificationBody => 'Waktunya mulai belajar!';

  @override
  String get language => 'Bahasa';

  @override
  String get selectLanguage => 'Pilih bahasa';

  @override
  String get languageSystem => 'Sistem';

  @override
  String get soundAndVibration => 'Suara & getar';

  @override
  String get soundEffects => 'Efek suara';

  @override
  String get soundEffectsDesc => 'Putar suara saat benar/salah';

  @override
  String get vibration => 'Getar';

  @override
  String get vibrationDesc => 'Getar saat benar/salah';

  @override
  String get ttsSettings => 'Pengaturan TTS';

  @override
  String get ttsAutoPlay => 'Putar otomatis';

  @override
  String get ttsAutoPlayDesc => 'Ucapkan bahasa Spanyol otomatis saat benar';

  @override
  String get showHint => 'Lihat petunjuk';

  @override
  String get nextQuestion => 'Pertanyaan berikutnya';

  @override
  String get keyPoints => 'Poin penting';

  @override
  String get theoryComplete => 'Selesai';

  @override
  String get excellentComplete => 'Luar biasa!';

  @override
  String get goodComplete => 'Bagus!';

  @override
  String get phaseResults => 'Hasil per fase';

  @override
  String get additionalStudy => 'Lanjut belajar';

  @override
  String continueReviewWithCount(int count) {
    return 'Lanjut ulasan ($count tersisa)';
  }
}
