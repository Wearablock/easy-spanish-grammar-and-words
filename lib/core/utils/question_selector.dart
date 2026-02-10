import 'dart:math';
import '../config/constants.dart';
import '../../data/database/app_database.dart';
import '../../data/models/question.dart';
import '../../data/repositories/question_repository.dart';

/// 일일 문제 배분 결과
class DailyAllocation {
  final int wrongReview;
  final int spacedReview;
  final int newLearning;

  const DailyAllocation({
    required this.wrongReview,
    required this.spacedReview,
    required this.newLearning,
  });

  int get total => wrongReview + spacedReview + newLearning;

  @override
  String toString() {
    return 'DailyAllocation(wrong: $wrongReview, spaced: $spacedReview, new: $newLearning, total: $total)';
  }
}

/// 일일 문제 선택 결과
class DailyQuestionSelection {
  final List<String> wrongReviewIds;
  final List<String> spacedReviewIds;
  final List<String> newQuestionIds;
  final List<String> newTopicIds;

  /// 토픽별 신규 문제 ID (토픽 순서대로)
  final Map<String, List<String>> newQuestionsByTopic;

  const DailyQuestionSelection({
    required this.wrongReviewIds,
    required this.spacedReviewIds,
    required this.newQuestionIds,
    required this.newTopicIds,
    required this.newQuestionsByTopic,
  });

  List<String> get allQuestionIds => [
        ...wrongReviewIds,
        ...spacedReviewIds,
        ...newQuestionIds,
      ];

  int get totalCount => allQuestionIds.length;

  bool get isEmpty => totalCount == 0;

  @override
  String toString() {
    return 'DailyQuestionSelection(wrong: ${wrongReviewIds.length}, spaced: ${spacedReviewIds.length}, new: ${newQuestionIds.length})';
  }
}

class QuestionSelector {
  final AppDatabase _db;
  final QuestionRepository _questionRepository;

  QuestionSelector(this._db, this._questionRepository);

  /// 토픽별 문제 맵 생성
  Map<String, List<QuestionMeta>> _buildTopicMap(
    List<QuestionMeta> allMeta,
  ) {
    final topicMap = <String, List<QuestionMeta>>{};
    for (final meta in allMeta) {
      topicMap.putIfAbsent(meta.topicId, () => []).add(meta);
    }
    return topicMap;
  }

  /// 미학습 토픽 목록 조회 (순서 유지)
  List<String> _findUnstudiedTopics({
    required List<QuestionMeta> allMeta,
    required Set<String> studiedIds,
  }) {
    final unstudiedTopics = <String>[];
    final seenTopics = <String>{};

    for (final meta in allMeta) {
      if (!studiedIds.contains(meta.id) &&
          !seenTopics.contains(meta.topicId)) {
        seenTopics.add(meta.topicId);
        unstudiedTopics.add(meta.topicId);
      }
    }

    return unstudiedTopics;
  }

  /// 일일 문제 배분 계산
  DailyAllocation calculateAllocation({
    required int dailyGoal,
    required int availableWrongCount,
    required int availableReviewCount,
    required int availableNewCount,
  }) {
    // 복습 총 할당: 최대 maxReviewCount개 또는 목표의 2/3
    final maxReview =
        min(StudyConstants.maxReviewCount, dailyGoal * 2 ~/ 3);
    // 오답 복습 우선 배분
    var wrongAllocation = min(availableWrongCount, maxReview);
    // 나머지를 망각곡선 복습에 배분
    final remainingReview = maxReview - wrongAllocation;
    var spacedAllocation = min(availableReviewCount, remainingReview);

    // 신규 학습: 나머지 (최소 minNewLearningCount개 보장)
    var newAllocation = dailyGoal - wrongAllocation - spacedAllocation;

    // 신규 학습이 최소 개수는 되도록 조정
    if (newAllocation < StudyConstants.minNewLearningCount &&
        dailyGoal >= 1 &&
        availableNewCount >= StudyConstants.minNewLearningCount) {
      final shortage =
          StudyConstants.minNewLearningCount - newAllocation;
      if (spacedAllocation >= shortage) {
        spacedAllocation -= shortage;
        newAllocation = StudyConstants.minNewLearningCount;
      } else if (wrongAllocation >= shortage) {
        wrongAllocation -= shortage;
        newAllocation = StudyConstants.minNewLearningCount;
      }
    }

    // 가용 신규 문제 수로 제한
    newAllocation = min(newAllocation, availableNewCount);

    // 신규 문제가 부족하면 복습 문제로 채움
    if (newAllocation <
        (dailyGoal - wrongAllocation - spacedAllocation)) {
      final remaining =
          dailyGoal - wrongAllocation - spacedAllocation - newAllocation;
      final additionalReview =
          min(remaining, availableReviewCount - spacedAllocation);
      spacedAllocation += additionalReview;
    }

    return DailyAllocation(
      wrongReview: wrongAllocation,
      spacedReview: spacedAllocation,
      newLearning: newAllocation,
    );
  }

  /// 오늘의 학습 문제 선택
  Future<DailyQuestionSelection> selectDailyQuestions({
    required int dailyGoal,
  }) async {
    // 1. 가용 문제 수 조회
    final reviewRecords =
        await _db.studyRecordsDao.getReviewQuestions(limit: 1000);
    final wrongRecords =
        reviewRecords.where((r) => r.level == 0).toList();
    final spacedRecords =
        reviewRecords.where((r) => r.level > 0).toList();

    final allStudiedIds = await _getAllStudiedQuestionIds();
    final allQuestionMeta = await _questionRepository.loadMeta();
    final allQuestionIds =
        allQuestionMeta.map((m) => m.id).toSet();
    final unstudiedIds = allQuestionIds.difference(allStudiedIds);

    // 2. 배분 계산
    final allocation = calculateAllocation(
      dailyGoal: dailyGoal,
      availableWrongCount: wrongRecords.length,
      availableReviewCount: spacedRecords.length,
      availableNewCount: unstudiedIds.length,
    );

    // 3. 오답 문제 선택 (레벨 0)
    final wrongReviewIds = wrongRecords
        .take(allocation.wrongReview)
        .map((r) => r.questionId)
        .toList();

    // 4. 망각곡선 복습 문제 선택 (레벨 1+)
    final spacedReviewIds = spacedRecords
        .take(allocation.spacedReview)
        .map((r) => r.questionId)
        .toList();

    // 5. 신규 문제 선택 (토픽 순서대로)
    final sortedUnstudied = allQuestionMeta
        .where((m) => unstudiedIds.contains(m.id))
        .toList();

    final newQuestionIds = sortedUnstudied
        .take(allocation.newLearning)
        .map((m) => m.id)
        .toList();

    // 6. 신규 문제의 토픽 ID 추출 및 토픽별 그룹화
    final newTopicIds = <String>[];
    final seenTopics = <String>{};
    final newQuestionsByTopic = <String, List<String>>{};

    for (final meta
        in sortedUnstudied.take(allocation.newLearning)) {
      if (!seenTopics.contains(meta.topicId)) {
        seenTopics.add(meta.topicId);
        newTopicIds.add(meta.topicId);
        newQuestionsByTopic[meta.topicId] = [];
      }
      newQuestionsByTopic[meta.topicId]!.add(meta.id);
    }

    return DailyQuestionSelection(
      wrongReviewIds: wrongReviewIds,
      spacedReviewIds: spacedReviewIds,
      newQuestionIds: newQuestionIds,
      newTopicIds: newTopicIds,
      newQuestionsByTopic: newQuestionsByTopic,
    );
  }

  /// 학습한 모든 문제 ID 조회
  Future<Set<String>> _getAllStudiedQuestionIds() async {
    final records = await _db.studyRecordsDao.getAllRecords();
    return records.map((r) => r.questionId).toSet();
  }

  /// 특정 토픽의 신규 문제 선택
  Future<List<String>> selectNewQuestionsFromTopic(
    String topicId, {
    int? limit,
  }) async {
    final studiedRecords =
        await _db.studyRecordsDao.getByTopicId(topicId);
    final studiedIds =
        studiedRecords.map((r) => r.questionId).toSet();

    final topicQuestionIds =
        await _questionRepository.getQuestionIdsByTopic(topicId);

    final unstudiedIds = topicQuestionIds
        .where((id) => !studiedIds.contains(id))
        .toList();

    if (limit != null) {
      return unstudiedIds.take(limit).toList();
    }
    return unstudiedIds;
  }

  /// 복습이 필요한 총 문제 수
  Future<int> getReviewDueCount() async {
    final reviewRecords =
        await _db.studyRecordsDao.getReviewQuestions(limit: 1000);
    return reviewRecords.length;
  }

  /// 오늘 남은 학습량 계산
  Future<int> getRemainingDailyCount({
    required int dailyGoal,
  }) async {
    final todayStudied =
        await _db.studyRecordsDao.getTodayStudiedCount();
    return max(0, dailyGoal - todayStudied);
  }

  /// 학습 가능한 총 문제 수 (신규 + 복습)
  Future<int> getAvailableQuestionCount() async {
    final results = await Future.wait([
      _db.studyRecordsDao.getReviewQuestions(limit: 1000),
      _getAllStudiedQuestionIds(),
      _questionRepository.loadMeta(),
    ]);
    final reviewRecords = results[0] as List<StudyRecord>;
    final allStudiedIds = results[1] as Set<String>;
    final allQuestionMeta = results[2] as List<QuestionMeta>;

    final unstudiedCount = allQuestionMeta
        .where((m) => !allStudiedIds.contains(m.id))
        .length;

    return reviewRecords.length + unstudiedCount;
  }

  /// 복습 전용 문제 선택
  Future<DailyQuestionSelection> selectReviewQuestions({
    int? maxTotal,
  }) async {
    maxTotal ??= StudyConstants.maxReviewCount;

    final reviewRecords = await _db.studyRecordsDao
        .getReviewQuestions(limit: maxTotal);

    final wrongReviewIds = reviewRecords
        .where((r) => r.level == 0)
        .map((r) => r.questionId)
        .toList();

    final remaining = maxTotal - wrongReviewIds.length;
    final spacedReviewIds = reviewRecords
        .where((r) => r.level > 0)
        .take(remaining)
        .map((r) => r.questionId)
        .toList();

    return DailyQuestionSelection(
      wrongReviewIds: wrongReviewIds,
      spacedReviewIds: spacedReviewIds,
      newQuestionIds: [],
      newTopicIds: [],
      newQuestionsByTopic: {},
    );
  }

  /// 단일 토픽 문제 선택 (신규 학습용)
  Future<DailyQuestionSelection> selectSingleTopicQuestions() async {
    return selectMultiTopicQuestions(topicCount: 1);
  }

  /// 복수 토픽 문제 선택 (일일 학습용)
  Future<DailyQuestionSelection> selectMultiTopicQuestions({
    required int topicCount,
  }) async {
    final results = await Future.wait([
      _getAllStudiedQuestionIds(),
      _questionRepository.loadMeta(),
    ]);
    final allStudiedIds = results[0] as Set<String>;
    final allQuestionMeta = results[1] as List<QuestionMeta>;

    final unstudiedTopics = _findUnstudiedTopics(
      allMeta: allQuestionMeta,
      studiedIds: allStudiedIds,
    );

    if (unstudiedTopics.isEmpty) {
      return const DailyQuestionSelection(
        wrongReviewIds: [],
        spacedReviewIds: [],
        newQuestionIds: [],
        newTopicIds: [],
        newQuestionsByTopic: {},
      );
    }

    final targetTopics =
        unstudiedTopics.take(topicCount).toList();
    final topicMap = _buildTopicMap(allQuestionMeta);

    final newQuestionIds = <String>[];
    final newQuestionsByTopic = <String, List<String>>{};

    for (final topicId in targetTopics) {
      final topicMeta = topicMap[topicId] ?? [];
      final topicQuestions = topicMeta
          .where((m) => !allStudiedIds.contains(m.id))
          .map((m) => m.id)
          .toList();

      newQuestionsByTopic[topicId] = topicQuestions;
      newQuestionIds.addAll(topicQuestions);
    }

    return DailyQuestionSelection(
      wrongReviewIds: [],
      spacedReviewIds: [],
      newQuestionIds: newQuestionIds,
      newTopicIds: targetTopics,
      newQuestionsByTopic: newQuestionsByTopic,
    );
  }

  /// 복습 + 신규 토픽 통합 선택 (일일 학습용)
  Future<DailyQuestionSelection> selectDailyTopicQuestions({
    required int topicCount,
  }) async {
    // 1. 복습 문제 선택
    final reviewRecords = await _db.studyRecordsDao
        .getReviewQuestions(limit: 1000);
    final wrongRecords =
        reviewRecords.where((r) => r.level == 0).toList();
    final spacedRecords =
        reviewRecords.where((r) => r.level > 0).toList();

    final wrongReviewIds = wrongRecords
        .take(StudyConstants.maxReviewCount)
        .map((r) => r.questionId)
        .toList();

    final remainingSlots =
        StudyConstants.maxReviewCount - wrongReviewIds.length;
    final spacedReviewIds = spacedRecords
        .take(max(0, remainingSlots))
        .map((r) => r.questionId)
        .toList();

    // 2. 신규 토픽 문제 선택
    final newTopicSelection = await selectMultiTopicQuestions(
      topicCount: topicCount,
    );

    return DailyQuestionSelection(
      wrongReviewIds: wrongReviewIds,
      spacedReviewIds: spacedReviewIds,
      newQuestionIds: newTopicSelection.newQuestionIds,
      newTopicIds: newTopicSelection.newTopicIds,
      newQuestionsByTopic: newTopicSelection.newQuestionsByTopic,
    );
  }

  /// 남은 학습 토픽 수 조회
  Future<int> getRemainingTopicCount() async {
    final results = await Future.wait([
      _getAllStudiedQuestionIds(),
      _questionRepository.loadMeta(),
    ]);
    final allStudiedIds = results[0] as Set<String>;
    final allQuestionMeta = results[1] as List<QuestionMeta>;

    return _findUnstudiedTopics(
      allMeta: allQuestionMeta,
      studiedIds: allStudiedIds,
    ).length;
  }

  /// 미학습 토픽 목록 조회 (순서대로)
  Future<List<String>> getUnstudiedTopicIds() async {
    final results = await Future.wait([
      _getAllStudiedQuestionIds(),
      _questionRepository.loadMeta(),
    ]);
    final allStudiedIds = results[0] as Set<String>;
    final allQuestionMeta = results[1] as List<QuestionMeta>;

    return _findUnstudiedTopics(
      allMeta: allQuestionMeta,
      studiedIds: allStudiedIds,
    );
  }
}
