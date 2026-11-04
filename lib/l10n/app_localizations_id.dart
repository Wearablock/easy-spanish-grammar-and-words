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
  String get goHome => 'Beranda';

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
  String get purchaseFailed => 'Pembelian gagal';

  @override
  String get purchasesRestored => 'Pembelian dipulihkan';

  @override
  String get productNotAvailable => 'Produk tidak tersedia';

  @override
  String get studyNotification => 'Pengingat belajar';

  @override
  String get dailyNotification =>
      'Pengingat harian di jam pilihanmu, dan satu lagi jika kamu melewatkan sehari';

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
  String get ttsSettings => 'Pengaturan suara';

  @override
  String get ttsAutoPlay => 'Putar otomatis';

  @override
  String get ttsAutoPlayDesc => 'Ucapkan bahasa Spanyol otomatis saat benar';

  @override
  String get ttsSpeechRate => 'Kecepatan';

  @override
  String get ttsVoice => 'Suara';

  @override
  String get ttsVoiceDefault => 'Default';

  @override
  String get ttsSpeedSlow => 'Lambat';

  @override
  String get ttsSpeedNormal => 'Normal';

  @override
  String get ttsSpeedFast => 'Cepat';

  @override
  String get ttsTestPlay => 'Pratinjau';

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

  @override
  String get totalStudied => 'Total dipelajari';

  @override
  String get accuracyRate => 'Tingkat akurasi';

  @override
  String get studyDays => 'Hari belajar';

  @override
  String get studyTime => 'Waktu belajar';

  @override
  String get currentStreak => 'Seri saat ini';

  @override
  String get longestStreak => 'Seri terpanjang';

  @override
  String get streakEncouragement => 'Terus belajar untuk berkembang!';

  @override
  String get noStudyYet => 'Belum ada data belajar';

  @override
  String daysUnit(int count) {
    return '$count hari';
  }

  @override
  String minutes(int count) {
    return '$count menit';
  }

  @override
  String get selectDailyGoal => 'Pilih target harian';

  @override
  String get selectTargetLevel => 'Pilih level target';

  @override
  String get notificationMsg1 =>
      'Kemampuan bahasa Spanyolmu menunggu! Siap melangkah lebih jauh hari ini?';

  @override
  String get notificationMsg2 =>
      'Masih ingat pelajaran kemarin? Mengulang membantu mengingat lebih lama!';

  @override
  String get notificationMsg3 =>
      'Sedikit setiap hari! Mulai pelajaran bahasa Spanyolmu hari ini.';

  @override
  String get notificationMsg4 =>
      '¡Hola! Kami merindukanmu. Ayo belajar bahasa Spanyol bersama hari ini!';

  @override
  String get notificationMsg5 =>
      'Jangan putus rekor belajarmu! Mulai belajar sekarang.';

  @override
  String get howManyTopics => 'Berapa topik per hari?';

  @override
  String get oneTopic => '1 topik';

  @override
  String get twoTopics => '2 topik';

  @override
  String get threeTopics => '3 topik';

  @override
  String get lightStart => 'Mulai ringan';

  @override
  String get moderateAmount => 'Jumlah sedang';

  @override
  String get intensiveStudy => 'Belajar intensif';

  @override
  String get topicList => 'Daftar topik';

  @override
  String get notStudiedYet => 'Belum dipelajari';

  @override
  String get studiedLabel => 'Sudah dipelajari';

  @override
  String topicCount(int count) {
    return '$count topik';
  }

  @override
  String get speakingPractice => 'Latihan Berbicara';

  @override
  String get speakingTest => 'Tes Berbicara';

  @override
  String get speakingBrowseAll => 'Jelajahi semua';

  @override
  String get speakingFeatureDesc =>
      'Latih dan uji puluhan variasi dari satu kalimat: ubah subjek, negasi, pertanyaan, ganti kata.';

  @override
  String get practice => 'Latih';

  @override
  String get test => 'Tes';

  @override
  String cardsCount(int count) {
    return '$count kartu';
  }

  @override
  String loadFailedError(String error) {
    return 'Gagal memuat: $error';
  }

  @override
  String get noSeeds => 'Tidak ada kalimat dasar.';

  @override
  String get showMeaning => 'Lihat arti';

  @override
  String get speakAgain => 'Bicara lagi';

  @override
  String get nextCard => 'Berikutnya';

  @override
  String get viewResult => 'Lihat hasil';

  @override
  String get listening => 'Mendengarkan…';

  @override
  String get tapMicToSpeak => 'Ketuk mikrofon dan ulangi';

  @override
  String get iSaid => 'Yang kamu ucapkan';

  @override
  String get correctAnswerLabel => 'Jawaban';

  @override
  String get micPermissionRequired =>
      'Izin mikrofon dan pengenalan suara diperlukan. Aktifkan di Pengaturan.';

  @override
  String speechError(String error) {
    return 'Kesalahan pengenalan suara: $error';
  }

  @override
  String get practiceResult => 'Hasil latihan';

  @override
  String get testResult => 'Hasil tes';

  @override
  String passedOfTotal(int passed, int total) {
    return '$passed / $total lulus';
  }

  @override
  String averageAccuracy(String percent) {
    return 'Akurasi rata-rata $percent';
  }

  @override
  String get testPassed => '🎉 Lulus!';

  @override
  String get testFailed => 'Hampir. Coba lagi!';

  @override
  String get sayInSpanishHint => 'Lihat dan ucapkan dalam bahasa Spanyol';

  @override
  String get variationBase => 'Kalimat dasar';

  @override
  String variationSubject(String subject) {
    return 'Subjek · $subject';
  }

  @override
  String get variationNegative => 'Negasi';

  @override
  String get variationInterrogative => 'Pertanyaan';

  @override
  String variationNounSwap(String noun) {
    return 'Ganti kata · $noun';
  }

  @override
  String get variationPhrase => 'Ungkapan';

  @override
  String get feedbackPerfect => 'Sempurna! 🎉';

  @override
  String get feedbackGreat => 'Hebat! 👏';

  @override
  String get feedbackGood => 'Bagus. Sekali lagi!';

  @override
  String get feedbackKeepPractice => 'Terus berlatih.';

  @override
  String get feedbackTryAgain => 'Coba lagi.';

  @override
  String get openSettings => 'Buka Pengaturan';

  @override
  String attemptCounter(int current, int total) {
    return 'Percobaan $current/$total';
  }

  @override
  String get playHint => 'Petunjuk pengucapan';

  @override
  String get speakingReview => 'Ulasan Berbicara';

  @override
  String speakingReviewDue(int count) {
    return '$count kartu untuk diulas';
  }

  @override
  String get noReviewDue => 'Tidak ada kartu untuk diulas.\nSampai jumpa!';

  @override
  String get searchHint => 'Cari…';

  @override
  String get quizListenPrompt => 'Dengarkan dan pilih kata yang hilang';

  @override
  String get quizTypePrompt => 'Ketik kata yang hilang';

  @override
  String get quizCheck => 'Periksa';

  @override
  String get quizSayIt => 'Sekarang ucapkan seluruh kalimat';

  @override
  String get badgeNew => 'BARU';

  @override
  String get speakPass => 'Bagus! Sudah cocok.';

  @override
  String get speakAlmost => 'Hampir. Dengarkan dan coba lagi.';

  @override
  String get speakTryAgain => 'Belum. Dengarkan sekali lagi.';

  @override
  String get speakSkip => 'Lewati';
}
