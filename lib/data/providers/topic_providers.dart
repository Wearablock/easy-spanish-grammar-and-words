import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/topic.dart';
import '../repositories/topic_repository.dart';

/// TopicRepository 인스턴스 제공
final topicRepositoryProvider = Provider<TopicRepository>((ref) {
  return TopicRepository();
});

/// 현재 콘텐츠 로케일 (앱 시작 시 설정됨)
final currentLocaleProvider = StateProvider<String>((ref) => 'ko');

/// 전체 토픽 목록 (현재 로케일 기준)
final topicsProvider = FutureProvider<List<Topic>>((ref) async {
  final repository = ref.watch(topicRepositoryProvider);
  final locale = ref.watch(currentLocaleProvider);
  return repository.loadTopics(locale);
});

/// 레벨별 토픽 목록
final topicsByLevelProvider =
    FutureProvider.family<List<Topic>, String>(
  (ref, levelId) async {
    final repository = ref.watch(topicRepositoryProvider);
    final locale = ref.watch(currentLocaleProvider);
    return repository.getTopicsByLevel(levelId, locale);
  },
);

/// 특정 토픽 조회
final topicByIdProvider = FutureProvider.family<Topic?, String>(
  (ref, topicId) async {
    final repository = ref.watch(topicRepositoryProvider);
    final locale = ref.watch(currentLocaleProvider);
    return repository.getTopicById(topicId, locale);
  },
);

/// 카테고리별 토픽 목록
final topicsByCategoryProvider =
    FutureProvider.family<List<Topic>, String>(
  (ref, categoryId) async {
    final repository = ref.watch(topicRepositoryProvider);
    final locale = ref.watch(currentLocaleProvider);
    return repository.getTopicsByCategory(categoryId, locale);
  },
);

/// 메타데이터만 (진행률 등, 로케일 무관)
final topicMetaProvider = FutureProvider<List<TopicMeta>>((ref) async {
  final repository = ref.watch(topicRepositoryProvider);
  return repository.loadMeta();
});

/// 전체 토픽 수
final topicCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(topicRepositoryProvider);
  return repository.getTopicCount();
});

/// 전체 문제 수 (토픽 메타에서 합산)
final totalQuestionCountProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(topicRepositoryProvider);
  return repository.getTotalQuestionCount();
});

/// 레벨별 토픽 수
final topicCountByLevelProvider =
    FutureProvider.family<int, String>(
  (ref, levelId) async {
    final repository = ref.watch(topicRepositoryProvider);
    return repository.getTopicCountByLevel(levelId);
  },
);

/// 레벨별 문제 수
final questionCountByLevelProvider =
    FutureProvider.family<int, String>(
  (ref, levelId) async {
    final repository = ref.watch(topicRepositoryProvider);
    return repository.getTotalQuestionCountByLevel(levelId);
  },
);
