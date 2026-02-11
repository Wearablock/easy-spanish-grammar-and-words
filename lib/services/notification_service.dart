import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// 24시간 비접속 동기부여 알림 서비스
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'study_reminder';
  static const int _reminderId = 1;

  String _channelName = 'Study Reminder';
  String _channelDescription = 'Inactivity study reminders';
  String _notificationTitle = 'Easy Spanish';

  /// 동기부여 메시지 풀 (l10n에서 설정)
  List<String> _motivationalMessages = [
    'Time to start today\'s study!',
  ];

  final Random _random = Random();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// l10n 문자열 설정
  void setLocalizedStrings({
    required String channelName,
    required String channelDescription,
    required String notificationTitle,
    required List<String> motivationalMessages,
  }) {
    _channelName = channelName;
    _channelDescription = channelDescription;
    _notificationTitle = notificationTitle;
    if (motivationalMessages.isNotEmpty) {
      _motivationalMessages = motivationalMessages;
    }
  }

  /// 알림 서비스 초기화
  Future<void> initialize() async {
    if (_isInitialized) return;

    // 시간대 초기화
    tz.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      final String timeZoneName = timezoneInfo.identifier;
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      debugPrint('시간대 설정 실패, 기본값 사용: $e');
      tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    }

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    await _createNotificationChannel();

    _isInitialized = true;
    debugPrint('NotificationService 초기화 완료');
  }

  Future<void> _createNotificationChannel() async {
    final androidChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
    );

    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  /// 알림 권한 요청
  Future<bool> requestPermission() async {
    if (Platform.isIOS) {
      final iosPlugin = _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();

      final granted = await iosPlugin?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    if (Platform.isAndroid) {
      final androidPlugin = _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final granted = await androidPlugin?.requestNotificationsPermission();
      return granted ?? true;
    }

    return true;
  }

  /// 알림 권한 확인
  Future<bool> hasPermission() async {
    if (Platform.isIOS) {
      final iosPlugin = _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();

      final settings = await iosPlugin?.checkPermissions();
      return settings?.isEnabled ?? false;
    }

    if (Platform.isAndroid) {
      final androidPlugin = _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final granted = await androidPlugin?.areNotificationsEnabled();
      return granted ?? true;
    }

    return true;
  }

  /// 24시간 후 1회성 비접속 알림 예약
  Future<void> scheduleInactivityReminder() async {
    if (!_isInitialized) {
      debugPrint('NotificationService가 초기화되지 않았습니다');
      return;
    }

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // now + 24h
    final scheduledTime =
        tz.TZDateTime.now(tz.local).add(const Duration(hours: 24));

    // 랜덤 동기부여 메시지 선택
    final body =
        _motivationalMessages[_random.nextInt(_motivationalMessages.length)];

    await _notifications.zonedSchedule(
      _reminderId,
      _notificationTitle,
      body,
      scheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );

    debugPrint('비접속 알림 예약됨: $scheduledTime');
  }

  /// 예약된 알림 취소
  Future<void> cancelReminder() async {
    await _notifications.cancel(_reminderId);
    debugPrint('비접속 알림 취소됨');
  }

  /// 기존 알림 취소 후 새로 24h 예약 (포그라운드 복귀 시 호출)
  Future<void> reschedule() async {
    await cancelReminder();
    await scheduleInactivityReminder();
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('알림 탭됨: ${response.payload}');
  }

  /// 예약된 알림 목록 조회 (디버그용)
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
}
