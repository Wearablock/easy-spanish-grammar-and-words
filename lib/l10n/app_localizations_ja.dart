// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'やさしいスペイン語';

  @override
  String get appFullTitle => 'やさしいスペイン語 - 文法と単語';

  @override
  String get home => 'ホーム';

  @override
  String get progress => '進捗';

  @override
  String get settings => '設定';

  @override
  String get wrongAnswers => '間違いノート';

  @override
  String error(String message) {
    return 'エラー: $message';
  }

  @override
  String get startStudy => '学習を始める';

  @override
  String get continueStudy => '学習を続ける';

  @override
  String get startReview => '復習する';

  @override
  String get todayStudy => '今日の学習';

  @override
  String get allTopicsCompleted => 'すべてのトピック学習完了！';

  @override
  String get reviewEncouragement => '復習で実力をさらに伸ばしましょう。';

  @override
  String get nextTopic => '次のトピック';

  @override
  String questionsCount(int count) {
    return '$count問';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '今日$count問学習完了';
  }

  @override
  String get todayGoal => '今日の目標';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal トピック';
  }

  @override
  String streakDays(int days) {
    return '$days日連続学習中！';
  }

  @override
  String get overallProgress => '全体の進捗';

  @override
  String get mastered => '完全習得';

  @override
  String get studiedOnce => '1回以上学習';

  @override
  String totalQuestions(int count) {
    return '全$count問';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total 問完全習得';
  }

  @override
  String get study => '学習';

  @override
  String get notifications => '通知';

  @override
  String get appSettings => 'アプリ設定';

  @override
  String get info => '情報';

  @override
  String get appVersion => 'アプリバージョン';

  @override
  String get termsAndPolicies => '利用規約・ポリシー';

  @override
  String get termsOfService => '利用規約';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get support => 'サポート';

  @override
  String get data => 'データ';

  @override
  String get resetStudyRecords => '学習記録をリセット';

  @override
  String get resetStudyRecordsDesc => 'すべての学習記録を削除します';

  @override
  String get resetStudyRecordsConfirm => 'すべての学習記録が削除されます。\nこの操作は元に戻せません。';

  @override
  String get cannotOpenLink => 'リンクを開けません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get reset => 'リセット';

  @override
  String get confirm => '確認';

  @override
  String get studyRecordsReset => '学習記録がリセットされました。';

  @override
  String get dailyStudyAmount => '1日の学習量';

  @override
  String topicsUnit(int count) {
    return '$countトピック';
  }

  @override
  String get customSetting => 'カスタム';

  @override
  String get theme => 'テーマ';

  @override
  String get selectTheme => 'テーマを選択';

  @override
  String get themeSystem => 'システム設定';

  @override
  String get themeLight => 'ライトモード';

  @override
  String get themeDark => 'ダークモード';

  @override
  String get studyComplete => '学習完了';

  @override
  String get goodJob => 'お疲れ様でした';

  @override
  String get goHome => 'ホームへ';

  @override
  String get accuracy => '正答率';

  @override
  String get correct => '正解';

  @override
  String get wrong => '不正解';

  @override
  String get timeSpent => '所要時間';

  @override
  String get wrongReview => '間違い復習';

  @override
  String get spacedReview => '間隔反復復習';

  @override
  String get newLearning => '新規学習';

  @override
  String get errorOccurred => 'エラーが発生しました';

  @override
  String get retry => '再試行';

  @override
  String get stopStudy => '学習を中断';

  @override
  String get stopStudyConfirm => '学習を中断しますか？\n現在までの進捗は保存されます。';

  @override
  String get continueStudyButton => '学習を続ける';

  @override
  String get stop => '中断';

  @override
  String get levelProgress => 'レベル別進捗';

  @override
  String get reviewAvailable => '復習する問題があります！';

  @override
  String reviewWaiting(int count) {
    return '$count問が復習を待っています';
  }

  @override
  String get welcome => 'ようこそ！';

  @override
  String get selectLevel => '目標レベルを選択してください';

  @override
  String get canChangeInSettings => '後で設定で変更できます';

  @override
  String get start => '始める';

  @override
  String get levelTarget => '目標レベル';

  @override
  String get levelNameA1 => '入門';

  @override
  String get levelNameA2 => '初級';

  @override
  String get levelNameB1 => '中級';

  @override
  String get levelNameB2 => '中上級';

  @override
  String get levelNameC1 => '上級';

  @override
  String get levelNameC2 => '最上級';

  @override
  String get grammar => '文法';

  @override
  String get vocabulary => '語彙';

  @override
  String get grammarAndVocabulary => '文法 & 語彙';

  @override
  String get noWrongAnswers => '間違いはありません！';

  @override
  String get noWrongAnswersDesc => '着実に学習を続けています。\nこの調子で頑張りましょう！';

  @override
  String wrongCount(int count) {
    return '$count回間違い';
  }

  @override
  String get correctAnswer => '正解';

  @override
  String get yourAnswer => 'あなたの回答';

  @override
  String get explanation => '解説';

  @override
  String get premium => 'プレミアム';

  @override
  String get removeAds => '広告を削除';

  @override
  String get premiumActivated => 'プレミアムが有効になりました';

  @override
  String get purchase => '購入';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get purchaseFailed => '購入に失敗しました';

  @override
  String get purchasesRestored => '購入が復元されました';

  @override
  String get productNotAvailable => '商品を読み込めません';

  @override
  String get studyNotification => '学習通知';

  @override
  String get dailyNotification => '1日以上アクセスしないと学習通知';

  @override
  String get notificationOff => '通知オフ';

  @override
  String get notificationTime => '通知時間';

  @override
  String get notificationChannelName => '学習リマインダー';

  @override
  String get notificationChannelDesc => '毎日の学習時間をお知らせします';

  @override
  String get notificationTitle => 'やさしいスペイン語';

  @override
  String get notificationBody => '今日の学習を始める時間です！';

  @override
  String get language => '言語';

  @override
  String get selectLanguage => '言語を選択';

  @override
  String get languageSystem => 'システム設定';

  @override
  String get soundAndVibration => 'サウンド・振動';

  @override
  String get soundEffects => '効果音';

  @override
  String get soundEffectsDesc => '正解/不正解時に効果音を再生';

  @override
  String get vibration => '振動';

  @override
  String get vibrationDesc => '正解/不正解時に振動フィードバック';

  @override
  String get ttsSettings => '音声設定';

  @override
  String get ttsAutoPlay => '自動再生';

  @override
  String get ttsAutoPlayDesc => '正解確認時にスペイン語を自動発音';

  @override
  String get ttsSpeechRate => '再生速度';

  @override
  String get ttsVoice => '音声の選択';

  @override
  String get ttsVoiceDefault => 'デフォルト';

  @override
  String get ttsSpeedSlow => '遅い';

  @override
  String get ttsSpeedNormal => '普通';

  @override
  String get ttsSpeedFast => '速い';

  @override
  String get ttsTestPlay => '試聴';

  @override
  String get showHint => 'ヒントを見る';

  @override
  String get nextQuestion => '次の問題';

  @override
  String get keyPoints => 'ポイント';

  @override
  String get theoryComplete => '学習完了';

  @override
  String get excellentComplete => '素晴らしい！';

  @override
  String get goodComplete => 'よくできました！';

  @override
  String get phaseResults => '段階別結果';

  @override
  String get additionalStudy => '追加学習';

  @override
  String continueReviewWithCount(int count) {
    return '復習を続ける（残り$count問）';
  }

  @override
  String get totalStudied => '総学習問題';

  @override
  String get accuracyRate => '正答率';

  @override
  String get studyDays => '学習日数';

  @override
  String get studyTime => '学習時間';

  @override
  String get currentStreak => '現在の連続学習';

  @override
  String get longestStreak => '最長連続学習';

  @override
  String get streakEncouragement => 'コツコツ学習すれば実力がぐんぐん伸びます！';

  @override
  String get noStudyYet => 'まだ学習記録がありません';

  @override
  String daysUnit(int count) {
    return '$count日';
  }

  @override
  String minutes(int count) {
    return '$count分';
  }

  @override
  String get selectDailyGoal => '1日の学習量を選択';

  @override
  String get selectTargetLevel => '目標レベルを選択';

  @override
  String get notificationMsg1 => 'スペイン語力が待っています！今日も一歩進みましょう。';

  @override
  String get notificationMsg2 => '昨日学んだこと、覚えていますか？復習すると記憶が長持ちします！';

  @override
  String get notificationMsg3 => '毎日コツコツ！今日のスペイン語学習を始めましょう。';

  @override
  String get notificationMsg4 => '¡Hola！スペイン語が恋しいです。今日も一緒に勉強しましょう！';

  @override
  String get notificationMsg5 => '連続学習記録が途切れる前に！今すぐ始めませんか？';
}
