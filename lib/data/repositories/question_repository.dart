import 'dart:convert';
import 'package:flutter/services.dart';
import '../../core/config/level_ids.dart';
import '../models/question.dart';

class QuestionRepository {
  // 레벨별 메타데이터 캐시
  final Map<String, List<QuestionMeta>> _metaCache = {};
  // 전체 메타데이터 캐시 (정렬됨)
  List<QuestionMeta>? _allMetaCache;
  // 레벨별 콘텐츠 캐시: {locale: {levelId: {questionId: content}}}
  final Map<String, Map<String, Map<String, QuestionContent>>>
      _contentCache = {};

  // ============================================================
  // ID 추출 유틸리티
  // ============================================================

  /// topicId에서 레벨 ID 추출
  /// ch_gram_a1_01 → grammar_a1
  /// ch_vocab_a2_03 → vocab_a2
  static String extractLevelFromTopicId(String topicId) {
    final withoutPrefix = topicId.replaceFirst('ch_', '');
    // gram_a1_01 또는 vocab_a2_03
    final parts = withoutPrefix.split('_');
    if (parts.length >= 3) {
      final category = parts[0] == 'gram' ? 'grammar' : 'vocab';
      return '${category}_${parts[1]}';
    }
    return withoutPrefix;
  }

  /// questionId에서 레벨 ID 추출
  /// q_gram_a1_01_001 → grammar_a1
  /// q_vocab_a2_03_005 → vocab_a2
  static String extractLevelFromQuestionId(String questionId) {
    final withoutPrefix = questionId.replaceFirst('q_', '');
    final parts = withoutPrefix.split('_');
    if (parts.length >= 4) {
      final category = parts[0] == 'gram' ? 'grammar' : 'vocab';
      return '${category}_${parts[1]}';
    }
    return withoutPrefix;
  }

  // ============================================================
  // 레벨별 메타데이터 로딩
  // ============================================================

  /// 특정 레벨의 메타데이터 로드
  Future<List<QuestionMeta>> loadMetaByLevel(String levelId) async {
    if (_metaCache.containsKey(levelId)) {
      return _metaCache[levelId]!;
    }

    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/questions/meta/$levelId.json',
      );
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final questionsList = jsonData['questions'] as List<dynamic>;

      final metaList = questionsList
          .map((q) => QuestionMeta.fromJson(q as Map<String, dynamic>))
          .toList();

      // topicId → order 순 정렬
      metaList.sort((a, b) {
        final topicCompare = a.topicId.compareTo(b.topicId);
        if (topicCompare != 0) return topicCompare;
        return a.order.compareTo(b.order);
      });

      _metaCache[levelId] = metaList;
      return metaList;
    } catch (e) {
      return [];
    }
  }

  /// 전체 메타데이터 로드 (모든 레벨) - 병렬 로딩
  Future<List<QuestionMeta>> loadMeta() async {
    if (_allMetaCache != null) return _allMetaCache!;

    final futures =
        LevelIds.all.map((levelId) => loadMetaByLevel(levelId));
    final results = await Future.wait(futures);

    final allMeta = <QuestionMeta>[];
    for (final levelMeta in results) {
      allMeta.addAll(levelMeta);
    }

    _allMetaCache = allMeta;
    return _allMetaCache!;
  }

  // ============================================================
  // 레벨별 콘텐츠 로딩
  // ============================================================

  /// 특정 레벨의 콘텐츠 로드
  Future<Map<String, QuestionContent>> loadContentByLevel(
    String levelId,
    String locale,
  ) async {
    _contentCache.putIfAbsent(locale, () => {});

    if (_contentCache[locale]!.containsKey(levelId)) {
      return _contentCache[locale]![levelId]!;
    }

    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/questions/$locale/$levelId.json',
      );
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      final contentMap = <String, QuestionContent>{};
      jsonData.forEach((key, value) {
        contentMap[key] =
            QuestionContent.fromJson(value as Map<String, dynamic>);
      });

      _contentCache[locale]![levelId] = contentMap;
      return contentMap;
    } catch (e) {
      return {};
    }
  }

  /// 특정 레벨의 콘텐츠 로드 (fallback 포함)
  Future<Map<String, QuestionContent>> loadContentByLevelWithFallback(
    String levelId,
    String locale,
  ) async {
    var content = await loadContentByLevel(levelId, locale);
    if (content.isNotEmpty) return content;

    if (locale != 'en') {
      content = await loadContentByLevel(levelId, 'en');
      if (content.isNotEmpty) return content;
    }

    if (locale != 'ko') {
      content = await loadContentByLevel(levelId, 'ko');
    }

    return content;
  }

  /// 전체 콘텐츠 로드 (모든 레벨) - 병렬 로딩
  Future<Map<String, QuestionContent>> loadContent(String locale) async {
    final futures = LevelIds.all.map(
      (levelId) => loadContentByLevelWithFallback(levelId, locale),
    );
    final results = await Future.wait(futures);

    final allContent = <String, QuestionContent>{};
    for (final levelContent in results) {
      allContent.addAll(levelContent);
    }

    return allContent;
  }

  // ============================================================
  // 문제 로딩 (메타 + 콘텐츠 결합)
  // ============================================================

  /// 특정 레벨의 문제 로드
  Future<List<Question>> loadQuestionsByLevel(
    String levelId,
    String locale,
  ) async {
    final metaList = await loadMetaByLevel(levelId);
    final contentMap =
        await loadContentByLevelWithFallback(levelId, locale);

    return metaList.map((meta) {
      final content = contentMap[meta.id];
      if (content != null) {
        return Question.fromMetaAndContent(meta, content);
      } else {
        return Question.fromMetaOnly(meta);
      }
    }).toList();
  }

  /// 전체 문제 로드 (모든 레벨) - 병렬 로딩
  Future<List<Question>> loadQuestions(String locale) async {
    final futures = LevelIds.all.map(
      (levelId) => loadQuestionsByLevel(levelId, locale),
    );
    final results = await Future.wait(futures);

    final allQuestions = <Question>[];
    for (final levelQuestions in results) {
      allQuestions.addAll(levelQuestions);
    }

    return allQuestions;
  }

  // ============================================================
  // 조회 메서드
  // ============================================================

  /// 특정 문제 ID로 조회
  Future<Question?> getQuestionById(
    String questionId,
    String locale,
  ) async {
    final levelId = extractLevelFromQuestionId(questionId);
    final questions = await loadQuestionsByLevel(levelId, locale);

    try {
      return questions.firstWhere((q) => q.id == questionId);
    } catch (e) {
      return null;
    }
  }

  /// 토픽별 문제 조회
  Future<List<Question>> getQuestionsByTopic(
    String topicId,
    String locale,
  ) async {
    final levelId = extractLevelFromTopicId(topicId);
    final questions = await loadQuestionsByLevel(levelId, locale);
    return questions.where((q) => q.topicId == topicId).toList();
  }

  /// 토픽별 문제 ID 목록 조회 (메타만 사용)
  Future<List<String>> getQuestionIdsByTopic(String topicId) async {
    final levelId = extractLevelFromTopicId(topicId);
    final metaList = await loadMetaByLevel(levelId);
    return metaList
        .where((m) => m.topicId == topicId)
        .map((m) => m.id)
        .toList();
  }

  /// 여러 문제 ID로 조회 - 병렬 로딩
  Future<List<Question>> getQuestionsByIds(
    List<String> questionIds,
    String locale,
  ) async {
    if (questionIds.isEmpty) return [];

    // 레벨별로 그룹화하여 효율적으로 로딩
    final idsByLevel = <String, Set<String>>{};
    for (final id in questionIds) {
      final levelId = extractLevelFromQuestionId(id);
      idsByLevel.putIfAbsent(levelId, () => {}).add(id);
    }

    // 병렬로 레벨별 문제 로드
    final futures = idsByLevel.entries.map((entry) async {
      final questions =
          await loadQuestionsByLevel(entry.key, locale);
      return questions
          .where((q) => entry.value.contains(q.id))
          .toList();
    });
    final results = await Future.wait(futures);

    final result = <Question>[];
    for (final questions in results) {
      result.addAll(questions);
    }

    // 원래 순서 유지
    final idOrder = {
      for (int i = 0; i < questionIds.length; i++) questionIds[i]: i
    };
    result.sort(
      (a, b) => (idOrder[a.id] ?? 0).compareTo(idOrder[b.id] ?? 0),
    );

    return result;
  }

  // ============================================================
  // 통계 메서드
  // ============================================================

  /// 전체 문제 수
  Future<int> getTotalQuestionCount() async {
    final metaList = await loadMeta();
    return metaList.length;
  }

  /// 레벨별 문제 수
  Future<int> getQuestionCountByLevel(String levelId) async {
    final metaList = await loadMetaByLevel(levelId);
    return metaList.length;
  }

  /// 토픽별 문제 수
  Future<int> getQuestionCountByTopic(String topicId) async {
    final levelId = extractLevelFromTopicId(topicId);
    final metaList = await loadMetaByLevel(levelId);
    return metaList.where((m) => m.topicId == topicId).length;
  }

  /// 난이도별 문제 조회
  Future<List<Question>> getQuestionsByDifficulty(
    int difficulty,
    String locale,
  ) async {
    final questions = await loadQuestions(locale);
    return questions.where((q) => q.difficulty == difficulty).toList();
  }

  /// 유형별 문제 조회
  Future<List<Question>> getQuestionsByType(
    QuestionType type,
    String locale,
  ) async {
    final questions = await loadQuestions(locale);
    return questions.where((q) => q.type == type).toList();
  }

  // ============================================================
  // 캐시 관리
  // ============================================================

  /// 전체 캐시 클리어
  void clearCache() {
    _metaCache.clear();
    _allMetaCache = null;
    _contentCache.clear();
  }

  /// 특정 로케일의 콘텐츠 캐시만 클리어
  void clearContentCache(String? locale) {
    if (locale != null) {
      _contentCache.remove(locale);
    } else {
      _contentCache.clear();
    }
  }

  /// 특정 레벨의 캐시 클리어
  void clearLevelCache(String levelId) {
    _metaCache.remove(levelId);
    _allMetaCache = null;
    for (final localeCache in _contentCache.values) {
      localeCache.remove(levelId);
    }
  }
}
