import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import '../../../core/config/constants.dart';
import '../../../core/config/setting_keys.dart';
import '../app_database.dart';
import '../tables/user_settings.dart';

part 'user_settings_dao.g.dart';

@DriftAccessor(tables: [UserSettings])
class UserSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$UserSettingsDaoMixin {
  UserSettingsDao(super.db);

  // ── 기본 CRUD ──

  Future<List<UserSetting>> getAllSettings() =>
      select(userSettings).get();

  Future<String?> getValue(String key) async {
    final setting = await (select(userSettings)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return setting?.value;
  }

  Future<void> setValue(String key, String? value) {
    return into(userSettings).insertOnConflictUpdate(
      UserSettingsCompanion(
        key: Value(key),
        value: Value(value),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteKey(String key) {
    return (delete(userSettings)..where((t) => t.key.equals(key))).go();
  }

  Future<int> deleteAll() => delete(userSettings).go();

  // ── 타입별 Getter/Setter ──

  Future<int> getInt(String key, {int defaultValue = 0}) async {
    final value = await getValue(key);
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) {
    return setValue(key, value.toString());
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    final value = await getValue(key);
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  Future<void> setBool(String key, bool value) {
    return setValue(key, value.toString());
  }

  Future<String> getString(String key,
      {String defaultValue = ''}) async {
    final value = await getValue(key);
    return value ?? defaultValue;
  }

  Future<void> setString(String key, String value) {
    return setValue(key, value);
  }

  // ── 학습 설정 ──

  Future<int> getDailyGoal() async {
    return getInt(SettingKeys.dailyGoal,
        defaultValue: StudyConstants.defaultDailyGoal);
  }

  Future<void> setDailyGoal(int topicCount) {
    final validCount =
        topicCount.clamp(1, StudyConstants.maxDailyGoalTopics);
    return setInt(SettingKeys.dailyGoal, validCount);
  }

  Future<bool> getReviewPriority() async {
    return getBool(SettingKeys.reviewPriority, defaultValue: true);
  }

  Future<void> setReviewPriority(bool enabled) {
    return setBool(SettingKeys.reviewPriority, enabled);
  }

  // ── DELE 목표 레벨 ──

  Future<String> getTargetLevel() async {
    return getString(SettingKeys.targetLevel,
        defaultValue: LevelConstants.defaultTargetLevel);
  }

  Future<void> setTargetLevel(String level) {
    return setString(SettingKeys.targetLevel, level);
  }

  Future<String> getStudyCategory() async {
    return getString(SettingKeys.studyCategory, defaultValue: 'all');
  }

  Future<void> setStudyCategory(String category) {
    return setString(SettingKeys.studyCategory, category);
  }

  // ── 알림 설정 ──

  Future<bool> getNotificationEnabled() async {
    return getBool(SettingKeys.notificationEnabled, defaultValue: false);
  }

  Future<void> setNotificationEnabled(bool enabled) {
    return setBool(SettingKeys.notificationEnabled, enabled);
  }

  Future<TimeOfDay> getNotificationTime() async {
    final hour =
        await getInt(SettingKeys.notificationHour, defaultValue: 20);
    final minute =
        await getInt(SettingKeys.notificationMinute, defaultValue: 0);
    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> setNotificationTime(TimeOfDay time) async {
    await setInt(SettingKeys.notificationHour, time.hour);
    await setInt(SettingKeys.notificationMinute, time.minute);
  }

  // ── 테마 설정 ──

  Future<String> getThemeMode() async {
    return getString(SettingKeys.themeMode, defaultValue: 'system');
  }

  Future<void> setThemeMode(String mode) {
    final validMode =
        ['system', 'light', 'dark'].contains(mode) ? mode : 'system';
    return setString(SettingKeys.themeMode, validMode);
  }

  // ── 사운드 & 진동 ──

  Future<bool> getSoundEnabled() async {
    return getBool(SettingKeys.soundEnabled, defaultValue: true);
  }

  Future<void> setSoundEnabled(bool enabled) {
    return setBool(SettingKeys.soundEnabled, enabled);
  }

  Future<bool> getVibrationEnabled() async {
    return getBool(SettingKeys.vibrationEnabled, defaultValue: true);
  }

  Future<void> setVibrationEnabled(bool enabled) {
    return setBool(SettingKeys.vibrationEnabled, enabled);
  }

  // ── TTS 설정 ──

  Future<bool> getTtsAutoPlay() async {
    return getBool(SettingKeys.ttsAutoPlay, defaultValue: false);
  }

  Future<void> setTtsAutoPlay(bool enabled) {
    return setBool(SettingKeys.ttsAutoPlay, enabled);
  }

  // ── 언어 설정 ──

  Future<String> getLocale() async {
    return getString(SettingKeys.locale, defaultValue: 'system');
  }

  Future<void> setLocale(String locale) {
    return setString(SettingKeys.locale, locale);
  }

  Future<String> getContentLocale() async {
    return getString(SettingKeys.contentLocale, defaultValue: 'system');
  }

  Future<void> setContentLocale(String locale) {
    return setString(SettingKeys.contentLocale, locale);
  }

  // ── 프리미엄 ──

  Future<bool> isPremium() async {
    return getBool(SettingKeys.isPremium, defaultValue: false);
  }

  Future<void> activatePremium() async {
    await setBool(SettingKeys.isPremium, true);
    await setString(
        SettingKeys.premiumPurchasedAt, DateTime.now().toIso8601String());
  }

  Future<void> deactivatePremium() {
    return setBool(SettingKeys.isPremium, false);
  }

  // ── 앱 상태 ──

  Future<bool> isFirstLaunch() async {
    final date = await getValue(SettingKeys.firstLaunchDate);
    return date == null;
  }

  Future<void> recordFirstLaunch() {
    return setString(
        SettingKeys.firstLaunchDate, DateTime.now().toIso8601String());
  }

  Future<bool> isOnboardingCompleted() async {
    return getBool(SettingKeys.onboardingCompleted, defaultValue: false);
  }

  Future<void> completeOnboarding() {
    return setBool(SettingKeys.onboardingCompleted, true);
  }

  // ── 리뷰 요청 ──

  Future<bool> canRequestReview() async {
    final lastPrompt = await getValue(SettingKeys.lastReviewPrompt);
    final promptCount =
        await getInt(SettingKeys.reviewPromptCount, defaultValue: 0);

    if (promptCount >= 3) return false;

    if (lastPrompt != null) {
      final lastDate = DateTime.tryParse(lastPrompt);
      if (lastDate != null) {
        final daysSinceLastPrompt =
            DateTime.now().difference(lastDate).inDays;
        if (daysSinceLastPrompt < 7) return false;
      }
    }

    return true;
  }

  Future<void> recordReviewPrompt() async {
    final currentCount =
        await getInt(SettingKeys.reviewPromptCount, defaultValue: 0);
    await setInt(SettingKeys.reviewPromptCount, currentCount + 1);
    await setString(
        SettingKeys.lastReviewPrompt, DateTime.now().toIso8601String());
  }

  // ── 일괄 설정 ──

  Future<void> resetToDefaults() async {
    await deleteAll();
    await setInt(SettingKeys.dailyGoal, StudyConstants.defaultDailyGoal);
    await setBool(SettingKeys.reviewPriority, true);
    await setBool(SettingKeys.shuffleOptions, true);
    await setBool(SettingKeys.showExplanation, true);
    await setString(
        SettingKeys.targetLevel, LevelConstants.defaultTargetLevel);
    await setString(SettingKeys.studyCategory, 'all');
    await setBool(SettingKeys.notificationEnabled, false);
    await setInt(SettingKeys.notificationHour, 20);
    await setInt(SettingKeys.notificationMinute, 0);
    await setBool(SettingKeys.streakReminder, true);
    await setString(SettingKeys.themeMode, 'system');
    await setString(SettingKeys.locale, 'system');
    await setString(SettingKeys.contentLocale, 'system');
    await setBool(SettingKeys.soundEnabled, true);
    await setBool(SettingKeys.vibrationEnabled, true);
    await setBool(SettingKeys.ttsAutoPlay, false);
  }

  Future<Map<String, String?>> exportSettings() async {
    final settings = await getAllSettings();
    return {for (var s in settings) s.key: s.value};
  }

  Future<void> importSettings(Map<String, String?> settings) async {
    for (final entry in settings.entries) {
      await setValue(entry.key, entry.value);
    }
  }

  // ── Stream (실시간 감지) ──

  Stream<String?> watchValue(String key) {
    return (select(userSettings)..where((t) => t.key.equals(key)))
        .watchSingleOrNull()
        .map((setting) => setting?.value);
  }

  Stream<String> watchThemeMode() {
    return watchValue(SettingKeys.themeMode)
        .map((value) => value ?? 'system');
  }

  Stream<String> watchLocale() {
    return watchValue(SettingKeys.locale)
        .map((value) => value ?? 'system');
  }

  Stream<bool> watchSoundEnabled() {
    return watchValue(SettingKeys.soundEnabled)
        .map((value) => value?.toLowerCase() == 'true' || value == null);
  }

  Stream<bool> watchVibrationEnabled() {
    return watchValue(SettingKeys.vibrationEnabled)
        .map((value) => value?.toLowerCase() == 'true' || value == null);
  }
}
