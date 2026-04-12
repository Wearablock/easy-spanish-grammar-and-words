import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';

/// 말하기 복습 대기 카드 수.
final speakingReviewDueCountProvider = FutureProvider<int>((ref) async {
  return AppDatabase().speakingProgressDao.getReviewDueCount();
});
