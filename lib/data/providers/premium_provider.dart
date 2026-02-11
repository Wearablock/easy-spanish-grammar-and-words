import 'package:flutter_riverpod/legacy.dart';

/// 프리미엄 구매 여부 (광고 제거)
/// IAP 연동 시 IAPService에서 상태 업데이트
final isPremiumProvider = StateProvider<bool>((ref) {
  return false;
});
