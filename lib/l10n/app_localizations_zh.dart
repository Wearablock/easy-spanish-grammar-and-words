// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '轻松学西语';

  @override
  String get appFullTitle => '轻松学西语 - 语法与词汇';

  @override
  String get home => '首页';

  @override
  String get progress => '进度';

  @override
  String get settings => '设置';

  @override
  String get wrongAnswers => '错题本';

  @override
  String error(String message) {
    return '错误: $message';
  }

  @override
  String get startStudy => '开始学习';

  @override
  String get continueStudy => '继续学习';

  @override
  String get startReview => '开始复习';

  @override
  String get todayStudy => '今日学习';

  @override
  String get allTopicsCompleted => '所有主题学习完成！';

  @override
  String get reviewEncouragement => '通过复习进一步提升实力吧。';

  @override
  String get nextTopic => '下一个主题';

  @override
  String questionsCount(int count) {
    return '$count题';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '今天完成$count题';
  }

  @override
  String get todayGoal => '今日目标';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal 主题';
  }

  @override
  String streakDays(int days) {
    return '连续学习$days天！';
  }

  @override
  String get overallProgress => '总体进度';

  @override
  String get mastered => '完全掌握';

  @override
  String get studiedOnce => '学习过1次以上';

  @override
  String totalQuestions(int count) {
    return '共$count题';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total 题完全掌握';
  }

  @override
  String get study => '学习';

  @override
  String get notifications => '通知';

  @override
  String get appSettings => '应用设置';

  @override
  String get info => '信息';

  @override
  String get appVersion => '应用版本';

  @override
  String get termsAndPolicies => '条款与政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get support => '客服支持';

  @override
  String get data => '数据';

  @override
  String get resetStudyRecords => '重置学习记录';

  @override
  String get resetStudyRecordsDesc => '删除所有学习记录';

  @override
  String get resetStudyRecordsConfirm => '所有学习记录将被删除。\n此操作无法撤销。';

  @override
  String get cannotOpenLink => '无法打开链接。';

  @override
  String get cancel => '取消';

  @override
  String get reset => '重置';

  @override
  String get confirm => '确认';

  @override
  String get studyRecordsReset => '学习记录已重置。';

  @override
  String get dailyStudyAmount => '每日学习量';

  @override
  String topicsUnit(int count) {
    return '$count个主题';
  }

  @override
  String get customSetting => '自定义';

  @override
  String get theme => '主题';

  @override
  String get selectTheme => '选择主题';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeLight => '浅色模式';

  @override
  String get themeDark => '深色模式';

  @override
  String get studyComplete => '学习完成';

  @override
  String get goodJob => '辛苦了';

  @override
  String get goHome => '返回首页';

  @override
  String get accuracy => '正确率';

  @override
  String get correct => '正确';

  @override
  String get wrong => '错误';

  @override
  String get timeSpent => '用时';

  @override
  String get wrongReview => '错题复习';

  @override
  String get spacedReview => '间隔复习';

  @override
  String get newLearning => '新学习';

  @override
  String get errorOccurred => '发生错误';

  @override
  String get retry => '重试';

  @override
  String get stopStudy => '停止学习';

  @override
  String get stopStudyConfirm => '要停止学习吗？\n当前进度将被保存。';

  @override
  String get continueStudyButton => '继续学习';

  @override
  String get stop => '停止';

  @override
  String get levelProgress => '各级别进度';

  @override
  String get reviewAvailable => '有需要复习的题目！';

  @override
  String reviewWaiting(int count) {
    return '$count道题等待复习';
  }

  @override
  String get welcome => '欢迎！';

  @override
  String get selectLevel => '请选择目标级别';

  @override
  String get canChangeInSettings => '之后可以在设置中修改';

  @override
  String get start => '开始';

  @override
  String get levelTarget => '目标级别';

  @override
  String get levelNameA1 => '入门';

  @override
  String get levelNameA2 => '初级';

  @override
  String get levelNameB1 => '中级';

  @override
  String get levelNameB2 => '中高级';

  @override
  String get levelNameC1 => '高级';

  @override
  String get levelNameC2 => '精通';

  @override
  String get grammar => '语法';

  @override
  String get vocabulary => '词汇';

  @override
  String get grammarAndVocabulary => '语法 & 词汇';

  @override
  String get noWrongAnswers => '没有错题！';

  @override
  String get noWrongAnswersDesc => '你一直在稳步学习。\n继续加油！';

  @override
  String wrongCount(int count) {
    return '错$count次';
  }

  @override
  String get correctAnswer => '正确答案';

  @override
  String get yourAnswer => '你的答案';

  @override
  String get explanation => '解析';

  @override
  String get premium => '高级版';

  @override
  String get removeAds => '移除广告';

  @override
  String get premiumActivated => '高级版已激活';

  @override
  String get purchase => '购买';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get purchaseFailed => '购买失败';

  @override
  String get purchasesRestored => '购买已恢复';

  @override
  String get productNotAvailable => '无法加载商品';

  @override
  String get studyNotification => '学习提醒';

  @override
  String get dailyNotification => '超过一天未访问时发送学习提醒';

  @override
  String get notificationOff => '通知已关闭';

  @override
  String get notificationTime => '通知时间';

  @override
  String get notificationChannelName => '学习提醒';

  @override
  String get notificationChannelDesc => '每天提醒您学习时间';

  @override
  String get notificationTitle => '轻松学西语';

  @override
  String get notificationBody => '是时候开始今天的学习了！';

  @override
  String get language => '语言';

  @override
  String get selectLanguage => '选择语言';

  @override
  String get languageSystem => '跟随系统';

  @override
  String get soundAndVibration => '声音与振动';

  @override
  String get soundEffects => '音效';

  @override
  String get soundEffectsDesc => '答对/答错时播放音效';

  @override
  String get vibration => '振动';

  @override
  String get vibrationDesc => '答对/答错时振动反馈';

  @override
  String get ttsSettings => '语音设置';

  @override
  String get ttsAutoPlay => '自动播放';

  @override
  String get ttsAutoPlayDesc => '答对时自动播放西班牙语发音';

  @override
  String get ttsSpeechRate => '播放速度';

  @override
  String get ttsVoice => '语音选择';

  @override
  String get ttsVoiceDefault => '默认';

  @override
  String get ttsSpeedSlow => '慢速';

  @override
  String get ttsSpeedNormal => '正常';

  @override
  String get ttsSpeedFast => '快速';

  @override
  String get ttsTestPlay => '试听';

  @override
  String get showHint => '查看提示';

  @override
  String get nextQuestion => '下一题';

  @override
  String get keyPoints => '要点';

  @override
  String get theoryComplete => '学习完成';

  @override
  String get excellentComplete => '太棒了！';

  @override
  String get goodComplete => '做得好！';

  @override
  String get phaseResults => '阶段结果';

  @override
  String get additionalStudy => '继续学习';

  @override
  String continueReviewWithCount(int count) {
    return '继续复习（剩余$count题）';
  }

  @override
  String get totalStudied => '总学习题数';

  @override
  String get accuracyRate => '正确率';

  @override
  String get studyDays => '学习天数';

  @override
  String get studyTime => '学习时间';

  @override
  String get currentStreak => '当前连续学习';

  @override
  String get longestStreak => '最长连续学习';

  @override
  String get streakEncouragement => '坚持学习，实力会不断提升！';

  @override
  String get noStudyYet => '还没有学习记录';

  @override
  String daysUnit(int count) {
    return '$count天';
  }

  @override
  String minutes(int count) {
    return '$count分钟';
  }

  @override
  String get selectDailyGoal => '选择每日学习量';

  @override
  String get selectTargetLevel => '选择目标级别';

  @override
  String get notificationMsg1 => '你的西班牙语在等你！今天也来进步一点吧？';

  @override
  String get notificationMsg2 => '还记得昨天学的内容吗？复习能记得更久！';

  @override
  String get notificationMsg3 => '每天一点点，坚持就是胜利！开始今天的西班牙语学习吧。';

  @override
  String get notificationMsg4 => '¡Hola！好久不见，今天一起学西班牙语吧！';

  @override
  String get notificationMsg5 => '别让连续学习记录中断！现在就开始吧。';

  @override
  String get howManyTopics => '每天学习几个主题？';

  @override
  String get oneTopic => '1个主题';

  @override
  String get twoTopics => '2个主题';

  @override
  String get threeTopics => '3个主题';

  @override
  String get lightStart => '轻松开始';

  @override
  String get moderateAmount => '适量学习';

  @override
  String get intensiveStudy => '集中学习';

  @override
  String get topicList => '主题列表';

  @override
  String get notStudiedYet => '未学习';

  @override
  String get studiedLabel => '已学习';

  @override
  String topicCount(int count) {
    return '$count个主题';
  }

  @override
  String get speakingPractice => '口语练习';

  @override
  String get speakingTest => '口语测试';

  @override
  String get speakingBrowseAll => '浏览全部';

  @override
  String get speakingFeatureDesc => '从一个句子开始，通过更换主语、否定、疑问、替换词汇练习数十种变体。';

  @override
  String get practice => '练习';

  @override
  String get test => '测试';

  @override
  String cardsCount(int count) {
    return '$count张卡片';
  }

  @override
  String loadFailedError(String error) {
    return '加载失败: $error';
  }

  @override
  String get noSeeds => '暂无种子句子。';

  @override
  String get showMeaning => '查看含义';

  @override
  String get speakAgain => '再说一次';

  @override
  String get nextCard => '下一个';

  @override
  String get viewResult => '查看结果';

  @override
  String get listening => '正在聆听…';

  @override
  String get tapMicToSpeak => '点击麦克风跟读';

  @override
  String get iSaid => '你说的';

  @override
  String get correctAnswerLabel => '答案';

  @override
  String get micPermissionRequired => '需要麦克风和语音识别权限。请在设置中允许。';

  @override
  String speechError(String error) {
    return '语音识别错误: $error';
  }

  @override
  String get practiceResult => '练习结果';

  @override
  String get testResult => '测试结果';

  @override
  String passedOfTotal(int passed, int total) {
    return '$passed / $total 通过';
  }

  @override
  String averageAccuracy(String percent) {
    return '平均准确率 $percent';
  }

  @override
  String get testPassed => '🎉 通过！';

  @override
  String get testFailed => '再接再厉，再试一次！';

  @override
  String get sayInSpanishHint => '看后用西班牙语说';

  @override
  String get variationBase => '基础句';

  @override
  String variationSubject(String subject) {
    return '主语 · $subject';
  }

  @override
  String get variationNegative => '否定句';

  @override
  String get variationInterrogative => '疑问句';

  @override
  String variationNounSwap(String noun) {
    return '替换词 · $noun';
  }

  @override
  String get variationPhrase => '惯用表达';

  @override
  String get feedbackPerfect => '完美！🎉';

  @override
  String get feedbackGreat => '很棒！👏';

  @override
  String get feedbackGood => '不错，再来一次！';

  @override
  String get feedbackKeepPractice => '再多练习一下。';

  @override
  String get feedbackTryAgain => '再试一次。';

  @override
  String get openSettings => '打开设置';

  @override
  String attemptCounter(int current, int total) {
    return '第 $current/$total 次';
  }

  @override
  String get playHint => '发音提示';

  @override
  String get speakingReview => '口语复习';

  @override
  String speakingReviewDue(int count) {
    return '$count 张待复习';
  }

  @override
  String get noReviewDue => '暂无需要复习的卡片。\n下次再见!';

  @override
  String get searchHint => '搜索…';

  @override
  String get quizListenPrompt => '听一听，选出空格里的词';

  @override
  String get quizTypePrompt => '输入空格里的词';

  @override
  String get quizCheck => '检查';

  @override
  String get quizSayIt => '把整句话说出来';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => '輕鬆學西語';

  @override
  String get appFullTitle => '輕鬆學西語 - 語法與詞彙';

  @override
  String get home => '首頁';

  @override
  String get progress => '進度';

  @override
  String get settings => '設定';

  @override
  String get wrongAnswers => '錯題本';

  @override
  String error(String message) {
    return '錯誤: $message';
  }

  @override
  String get startStudy => '開始學習';

  @override
  String get continueStudy => '繼續學習';

  @override
  String get startReview => '開始複習';

  @override
  String get todayStudy => '今日學習';

  @override
  String get allTopicsCompleted => '所有主題學習完成！';

  @override
  String get reviewEncouragement => '透過複習進一步提升實力吧。';

  @override
  String get nextTopic => '下一個主題';

  @override
  String questionsCount(int count) {
    return '$count題';
  }

  @override
  String todayQuestionsCompleted(int count) {
    return '今天完成$count題';
  }

  @override
  String get todayGoal => '今日目標';

  @override
  String topicsProgress(int studied, int goal) {
    return '$studied/$goal 主題';
  }

  @override
  String streakDays(int days) {
    return '連續學習$days天！';
  }

  @override
  String get overallProgress => '整體進度';

  @override
  String get mastered => '完全掌握';

  @override
  String get studiedOnce => '學習過1次以上';

  @override
  String totalQuestions(int count) {
    return '共$count題';
  }

  @override
  String questionsMastered(int count, int total) {
    return '$count / $total 題完全掌握';
  }

  @override
  String get study => '學習';

  @override
  String get notifications => '通知';

  @override
  String get appSettings => '應用設定';

  @override
  String get info => '資訊';

  @override
  String get appVersion => '應用版本';

  @override
  String get termsAndPolicies => '條款與政策';

  @override
  String get termsOfService => '服務條款';

  @override
  String get privacyPolicy => '隱私權政策';

  @override
  String get support => '客服支援';

  @override
  String get data => '資料';

  @override
  String get resetStudyRecords => '重置學習記錄';

  @override
  String get resetStudyRecordsDesc => '刪除所有學習記錄';

  @override
  String get resetStudyRecordsConfirm => '所有學習記錄將被刪除。\n此操作無法撤銷。';

  @override
  String get cannotOpenLink => '無法開啟連結。';

  @override
  String get cancel => '取消';

  @override
  String get reset => '重置';

  @override
  String get confirm => '確認';

  @override
  String get studyRecordsReset => '學習記錄已重置。';

  @override
  String get dailyStudyAmount => '每日學習量';

  @override
  String topicsUnit(int count) {
    return '$count個主題';
  }

  @override
  String get customSetting => '自訂';

  @override
  String get theme => '主題';

  @override
  String get selectTheme => '選擇主題';

  @override
  String get themeSystem => '跟隨系統';

  @override
  String get themeLight => '淺色模式';

  @override
  String get themeDark => '深色模式';

  @override
  String get studyComplete => '學習完成';

  @override
  String get goodJob => '辛苦了';

  @override
  String get goHome => '返回首頁';

  @override
  String get accuracy => '正確率';

  @override
  String get correct => '正確';

  @override
  String get wrong => '錯誤';

  @override
  String get timeSpent => '用時';

  @override
  String get wrongReview => '錯題複習';

  @override
  String get spacedReview => '間隔複習';

  @override
  String get newLearning => '新學習';

  @override
  String get errorOccurred => '發生錯誤';

  @override
  String get retry => '重試';

  @override
  String get stopStudy => '停止學習';

  @override
  String get stopStudyConfirm => '要停止學習嗎？\n目前進度將被儲存。';

  @override
  String get continueStudyButton => '繼續學習';

  @override
  String get stop => '停止';

  @override
  String get levelProgress => '各級別進度';

  @override
  String get reviewAvailable => '有需要複習的題目！';

  @override
  String reviewWaiting(int count) {
    return '$count道題等待複習';
  }

  @override
  String get welcome => '歡迎！';

  @override
  String get selectLevel => '請選擇目標級別';

  @override
  String get canChangeInSettings => '之後可以在設定中修改';

  @override
  String get start => '開始';

  @override
  String get levelTarget => '目標級別';

  @override
  String get levelNameA1 => '入門';

  @override
  String get levelNameA2 => '初級';

  @override
  String get levelNameB1 => '中級';

  @override
  String get levelNameB2 => '中高級';

  @override
  String get levelNameC1 => '高級';

  @override
  String get levelNameC2 => '精通';

  @override
  String get grammar => '文法';

  @override
  String get vocabulary => '詞彙';

  @override
  String get grammarAndVocabulary => '文法 & 詞彙';

  @override
  String get noWrongAnswers => '沒有錯題！';

  @override
  String get noWrongAnswersDesc => '你一直在穩步學習。\n繼續加油！';

  @override
  String wrongCount(int count) {
    return '錯$count次';
  }

  @override
  String get correctAnswer => '正確答案';

  @override
  String get yourAnswer => '你的答案';

  @override
  String get explanation => '解析';

  @override
  String get premium => '進階版';

  @override
  String get removeAds => '移除廣告';

  @override
  String get premiumActivated => '進階版已啟用';

  @override
  String get purchase => '購買';

  @override
  String get restorePurchases => '恢復購買';

  @override
  String get purchaseFailed => '購買失敗';

  @override
  String get purchasesRestored => '購買已恢復';

  @override
  String get productNotAvailable => '無法載入商品';

  @override
  String get studyNotification => '學習提醒';

  @override
  String get dailyNotification => '超過一天未訪問時發送學習提醒';

  @override
  String get notificationOff => '通知已關閉';

  @override
  String get notificationTime => '通知時間';

  @override
  String get notificationChannelName => '學習提醒';

  @override
  String get notificationChannelDesc => '每天提醒您學習時間';

  @override
  String get notificationTitle => '輕鬆學西語';

  @override
  String get notificationBody => '是時候開始今天的學習了！';

  @override
  String get language => '語言';

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get languageSystem => '跟隨系統';

  @override
  String get soundAndVibration => '聲音與振動';

  @override
  String get soundEffects => '音效';

  @override
  String get soundEffectsDesc => '答對/答錯時播放音效';

  @override
  String get vibration => '振動';

  @override
  String get vibrationDesc => '答對/答錯時振動回饋';

  @override
  String get ttsSettings => '語音設定';

  @override
  String get ttsAutoPlay => '自動播放';

  @override
  String get ttsAutoPlayDesc => '答對時自動播放西班牙語發音';

  @override
  String get ttsSpeechRate => '播放速度';

  @override
  String get ttsVoice => '語音選擇';

  @override
  String get ttsVoiceDefault => '預設';

  @override
  String get ttsSpeedSlow => '慢速';

  @override
  String get ttsSpeedNormal => '正常';

  @override
  String get ttsSpeedFast => '快速';

  @override
  String get ttsTestPlay => '試聽';

  @override
  String get showHint => '查看提示';

  @override
  String get nextQuestion => '下一題';

  @override
  String get keyPoints => '要點';

  @override
  String get theoryComplete => '學習完成';

  @override
  String get excellentComplete => '太棒了！';

  @override
  String get goodComplete => '做得好！';

  @override
  String get phaseResults => '階段結果';

  @override
  String get additionalStudy => '繼續學習';

  @override
  String continueReviewWithCount(int count) {
    return '繼續複習（剩餘$count題）';
  }

  @override
  String get totalStudied => '總學習題數';

  @override
  String get accuracyRate => '正確率';

  @override
  String get studyDays => '學習天數';

  @override
  String get studyTime => '學習時間';

  @override
  String get currentStreak => '目前連續學習';

  @override
  String get longestStreak => '最長連續學習';

  @override
  String get streakEncouragement => '堅持學習，實力會不斷提升！';

  @override
  String get noStudyYet => '還沒有學習記錄';

  @override
  String daysUnit(int count) {
    return '$count天';
  }

  @override
  String minutes(int count) {
    return '$count分鐘';
  }

  @override
  String get selectDailyGoal => '選擇每日學習量';

  @override
  String get selectTargetLevel => '選擇目標級別';

  @override
  String get notificationMsg1 => '你的西班牙語在等你！今天也來進步一點吧？';

  @override
  String get notificationMsg2 => '還記得昨天學的內容嗎？複習能記得更久！';

  @override
  String get notificationMsg3 => '每天一點點，堅持就是勝利！開始今天的西班牙語學習吧。';

  @override
  String get notificationMsg4 => '¡Hola！好久不見，今天一起學西班牙語吧！';

  @override
  String get notificationMsg5 => '別讓連續學習記錄中斷！現在就開始吧。';

  @override
  String get howManyTopics => '每天學習幾個主題？';

  @override
  String get oneTopic => '1個主題';

  @override
  String get twoTopics => '2個主題';

  @override
  String get threeTopics => '3個主題';

  @override
  String get lightStart => '輕鬆開始';

  @override
  String get moderateAmount => '適量學習';

  @override
  String get intensiveStudy => '集中學習';

  @override
  String get topicList => '主題列表';

  @override
  String get notStudiedYet => '未學習';

  @override
  String get studiedLabel => '已學習';

  @override
  String topicCount(int count) {
    return '$count個主題';
  }

  @override
  String get speakingPractice => '口語練習';

  @override
  String get speakingTest => '口語測試';

  @override
  String get speakingBrowseAll => '瀏覽全部';

  @override
  String get speakingFeatureDesc => '從一個句子開始，透過更換主語、否定、疑問、替換詞彙練習數十種變化。';

  @override
  String get practice => '練習';

  @override
  String get test => '測試';

  @override
  String cardsCount(int count) {
    return '$count張卡片';
  }

  @override
  String loadFailedError(String error) {
    return '載入失敗: $error';
  }

  @override
  String get noSeeds => '尚無種子句子。';

  @override
  String get showMeaning => '查看含義';

  @override
  String get speakAgain => '再說一次';

  @override
  String get nextCard => '下一個';

  @override
  String get viewResult => '查看結果';

  @override
  String get listening => '正在聆聽…';

  @override
  String get tapMicToSpeak => '點擊麥克風跟讀';

  @override
  String get iSaid => '你說的';

  @override
  String get correctAnswerLabel => '答案';

  @override
  String get micPermissionRequired => '需要麥克風和語音辨識權限。請在設定中允許。';

  @override
  String speechError(String error) {
    return '語音辨識錯誤: $error';
  }

  @override
  String get practiceResult => '練習結果';

  @override
  String get testResult => '測試結果';

  @override
  String passedOfTotal(int passed, int total) {
    return '$passed / $total 通過';
  }

  @override
  String averageAccuracy(String percent) {
    return '平均準確率 $percent';
  }

  @override
  String get testPassed => '🎉 通過！';

  @override
  String get testFailed => '再接再厲，再試一次！';

  @override
  String get sayInSpanishHint => '看後用西班牙語說';

  @override
  String get variationBase => '基礎句';

  @override
  String variationSubject(String subject) {
    return '主語 · $subject';
  }

  @override
  String get variationNegative => '否定句';

  @override
  String get variationInterrogative => '疑問句';

  @override
  String variationNounSwap(String noun) {
    return '替換詞 · $noun';
  }

  @override
  String get variationPhrase => '慣用表達';

  @override
  String get feedbackPerfect => '完美！🎉';

  @override
  String get feedbackGreat => '很棒！👏';

  @override
  String get feedbackGood => '不錯，再來一次！';

  @override
  String get feedbackKeepPractice => '再多練習一下。';

  @override
  String get feedbackTryAgain => '再試一次。';

  @override
  String get openSettings => '開啟設定';

  @override
  String attemptCounter(int current, int total) {
    return '第 $current/$total 次';
  }

  @override
  String get playHint => '發音提示';

  @override
  String get speakingReview => '口語複習';

  @override
  String speakingReviewDue(int count) {
    return '$count 張待複習';
  }

  @override
  String get noReviewDue => '暫無需要複習的卡片。\n下次再見!';

  @override
  String get searchHint => '搜尋…';

  @override
  String get quizListenPrompt => '聽一聽，選出空格裡的詞';

  @override
  String get quizTypePrompt => '輸入空格裡的詞';

  @override
  String get quizCheck => '檢查';

  @override
  String get quizSayIt => '把整句話說出來';
}
