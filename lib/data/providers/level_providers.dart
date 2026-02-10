import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/level.dart';
import '../repositories/level_repository.dart';

/// LevelRepository 인스턴스 제공
final levelRepositoryProvider = Provider<LevelRepository>((ref) {
  return LevelRepository();
});

/// 전체 레벨 목록
final levelsProvider = FutureProvider<List<Level>>((ref) async {
  final repository = ref.watch(levelRepositoryProvider);
  return repository.loadLevels();
});

/// 특정 레벨 조회
final levelByIdProvider = FutureProvider.family<Level?, String>(
  (ref, levelId) async {
    final repository = ref.watch(levelRepositoryProvider);
    return repository.getLevelById(levelId);
  },
);

/// 카테고리별 레벨 목록
final levelsByCategoryProvider =
    FutureProvider.family<List<Level>, String>(
  (ref, categoryId) async {
    final repository = ref.watch(levelRepositoryProvider);
    return repository.getLevelsByCategory(categoryId);
  },
);

/// 전체 레벨 수
final levelCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(levelRepositoryProvider);
  return repository.getLevelCount();
});
