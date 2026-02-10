import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/topic.dart';

class TopicRepository {
  // 캐시
  List<TopicMeta>? _cachedMeta;
  final Map<String, Map<String, TopicContent>> _cachedContent = {};

  // 현재 로드된 로케일의 통합 토픽 목록
  List<Topic>? _cachedTopics;
  String? _cachedLocale;

  /// 메타데이터 로드 (앱 시작 시 1회)
  Future<List<TopicMeta>> loadMeta() async {
    if (_cachedMeta != null) return _cachedMeta!;

    final jsonString = await rootBundle.loadString(
      'assets/data/topics/topics_meta.json',
    );
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final topicsJson = jsonData['topics'] as List<dynamic>;

    _cachedMeta = topicsJson
        .map((e) => TopicMeta.fromJson(e as Map<String, dynamic>))
        .toList();

    // levelId → order 순 정렬
    _cachedMeta!.sort((a, b) {
      final levelCompare = a.levelId.compareTo(b.levelId);
      if (levelCompare != 0) return levelCompare;
      return a.order.compareTo(b.order);
    });

    return _cachedMeta!;
  }

  /// 콘텐츠 로드 (로케일별)
  Future<Map<String, TopicContent>> loadContent(String locale) async {
    if (_cachedContent.containsKey(locale)) {
      return _cachedContent[locale]!;
    }

    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/topics/topics_$locale.json',
      );
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;

      final content = <String, TopicContent>{};
      jsonData.forEach((key, value) {
        content[key] =
            TopicContent.fromJson(value as Map<String, dynamic>);
      });

      _cachedContent[locale] = content;
      return content;
    } catch (e) {
      return {};
    }
  }

  /// 콘텐츠 로드 (fallback 적용: locale → en → ko)
  Future<Map<String, TopicContent>> loadContentWithFallback(
    String locale,
  ) async {
    var content = await loadContent(locale);
    if (content.isNotEmpty) return content;

    if (locale != 'en') {
      content = await loadContent('en');
      if (content.isNotEmpty) return content;
    }

    if (locale != 'ko') {
      content = await loadContent('ko');
    }

    return content;
  }

  /// 토픽 목록 로드 (메타 + 콘텐츠 병합)
  Future<List<Topic>> loadTopics(String locale) async {
    if (_cachedTopics != null && _cachedLocale == locale) {
      return _cachedTopics!;
    }

    final meta = await loadMeta();
    final content = await loadContentWithFallback(locale);

    _cachedTopics = meta.map((m) {
      final c = content[m.id] ?? TopicContent.empty;
      return Topic.fromMetaAndContent(m, c);
    }).toList();

    _cachedLocale = locale;
    return _cachedTopics!;
  }

  /// ID로 토픽 조회
  Future<Topic?> getTopicById(String id, String locale) async {
    final topics = await loadTopics(locale);
    try {
      return topics.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  /// 레벨별 토픽 목록 조회
  Future<List<Topic>> getTopicsByLevel(
    String levelId,
    String locale,
  ) async {
    final topics = await loadTopics(locale);
    return topics.where((t) => t.levelId == levelId).toList();
  }

  /// 카테고리별 토픽 목록
  Future<List<Topic>> getTopicsByCategory(
    String categoryId,
    String locale,
  ) async {
    final topics = await loadTopics(locale);
    return topics.where((t) => t.categoryId == categoryId).toList();
  }

  /// DELE 레벨별 토픽 목록
  Future<List<Topic>> getTopicsByDeleLevel(
    String deleLevel,
    String locale,
  ) async {
    final topics = await loadTopics(locale);
    return topics.where((t) => t.deleLevel == deleLevel).toList();
  }

  /// 전체 토픽 수 (메타만으로 가능)
  Future<int> getTopicCount() async {
    final meta = await loadMeta();
    return meta.length;
  }

  /// 레벨별 토픽 수
  Future<int> getTopicCountByLevel(String levelId) async {
    final meta = await loadMeta();
    return meta.where((m) => m.levelId == levelId).length;
  }

  /// 전체 문제 수
  Future<int> getTotalQuestionCount() async {
    final meta = await loadMeta();
    return meta.fold<int>(0, (sum, m) => sum + m.questionCount);
  }

  /// 레벨별 문제 수
  Future<int> getTotalQuestionCountByLevel(String levelId) async {
    final meta = await loadMeta();
    return meta
        .where((m) => m.levelId == levelId)
        .fold<int>(0, (sum, m) => sum + m.questionCount);
  }

  /// 메타데이터만 필요한 경우 (진행률 계산 등)
  Future<List<TopicMeta>> getMetaByLevel(String levelId) async {
    final meta = await loadMeta();
    return meta.where((m) => m.levelId == levelId).toList();
  }

  /// 캐시 초기화
  void clearCache() {
    _cachedMeta = null;
    _cachedContent.clear();
    _cachedTopics = null;
    _cachedLocale = null;
  }

  /// 콘텐츠 캐시만 초기화 (언어 변경 시)
  void clearContentCache() {
    _cachedContent.clear();
    _cachedTopics = null;
    _cachedLocale = null;
  }
}
