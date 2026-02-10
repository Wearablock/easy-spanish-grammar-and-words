/// 디버그 시간 유틸리티
/// 디버그 모드에서 시간을 인위적으로 변경하여 스페이스드 리피티션 테스트 가능
class DebugUtils {
  DebugUtils._();

  static DateTime? _overrideNow;

  /// 현재 시간 (디버그 오버라이드 지원)
  static DateTime get now => _overrideNow ?? DateTime.now();

  /// 디버그용 시간 오버라이드
  static void setNow(DateTime? dateTime) {
    _overrideNow = dateTime;
  }

  /// 오버라이드 해제
  static void resetNow() {
    _overrideNow = null;
  }
}
