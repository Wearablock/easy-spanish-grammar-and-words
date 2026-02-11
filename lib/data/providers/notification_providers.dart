import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/notification_service.dart';
import 'database_providers.dart';

/// NotificationService 싱글톤 인스턴스
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// 알림 활성화 여부 (DAO에서 읽기)
final notificationEnabledProvider = FutureProvider<bool>((ref) async {
  final dao = ref.watch(userSettingsDaoProvider);
  return dao.getNotificationEnabled();
});
