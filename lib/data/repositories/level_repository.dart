import 'dart:convert';
import 'package:flutter/services.dart';
import '../../core/config/constants.dart';
import '../models/level.dart';

class LevelRepository {
  List<Level>? _cachedLevels;

  /// JSON에서 레벨 목록 로드
  Future<List<Level>> loadLevels() async {
    if (_cachedLevels != null) return _cachedLevels!;

    final jsonString = await rootBundle.loadString('assets/data/levels.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final levelsJson = jsonData['levels'] as List<dynamic>;

    _cachedLevels = levelsJson
        .map((e) => Level.fromJson(e as Map<String, dynamic>))
        .toList();

    // order 기준 정렬
    _cachedLevels!.sort((a, b) => a.order.compareTo(b.order));

    return _cachedLevels!;
  }

  /// ID로 레벨 조회
  Future<Level?> getLevelById(String id) async {
    final levels = await loadLevels();
    try {
      return levels.firstWhere((l) => l.id == id);
    } catch (_) {
      return null;
    }
  }

  /// 카테고리별 레벨 목록
  Future<List<Level>> getLevelsByCategory(String categoryId) async {
    final levels = await loadLevels();
    return levels.where((l) => l.categoryId == categoryId).toList();
  }

  /// DELE 레벨별 필터
  Future<List<Level>> getLevelsByDeleLevel(String deleLevel) async {
    final levels = await loadLevels();
    return levels.where((l) => l.deleLevel == deleLevel).toList();
  }

  /// 목표 레벨 이하의 레벨 목록
  Future<List<Level>> getLevelsUpTo(String targetDeleLevel) async {
    final levels = await loadLevels();
    final targetOrder = LevelConstants.levelOrder[targetDeleLevel] ?? 3;
    return levels.where((l) {
      final levelOrder = LevelConstants.levelOrder[l.deleLevel] ?? 0;
      return levelOrder <= targetOrder;
    }).toList();
  }

  /// 전체 레벨 수
  Future<int> getLevelCount() async {
    final levels = await loadLevels();
    return levels.length;
  }

  /// 캐시 초기화
  void clearCache() {
    _cachedLevels = null;
  }
}
