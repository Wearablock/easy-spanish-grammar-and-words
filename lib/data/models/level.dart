import 'package:flutter/material.dart';

/// DELE 학습 레벨 (카테고리 + DELE 레벨 조합)
///
/// JSON 예시 (levels.json):
/// {
///   "id": "grammar_a1",
///   "category_id": "grammar",
///   "dele_level": "a1",
///   "order": 1,
///   "name": { "ko": "A1 기초 문법", "en": "A1 Basic Grammar" },
///   "description": { "ko": "스페인어의 기본 구조를 배웁니다" },
///   "color": "#4CAF50",
///   "icon": "menu_book"
/// }
class Level {
  final String id;
  final String categoryId;
  final String deleLevel;
  final int order;
  final Map<String, String> name;
  final Map<String, String>? description;
  final String? color;
  final String? icon;
  final Map<String, dynamic> extras;

  const Level({
    required this.id,
    required this.categoryId,
    required this.deleLevel,
    required this.order,
    required this.name,
    this.description,
    this.color,
    this.icon,
    this.extras = const {},
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    const knownKeys = {
      'id',
      'category_id',
      'dele_level',
      'order',
      'name',
      'description',
      'color',
      'icon',
    };

    return Level(
      id: json['id'] as String,
      categoryId: json['category_id'] as String? ?? '',
      deleLevel: json['dele_level'] as String? ?? '',
      order: json['order'] as int? ?? 0,
      name: json['name'] != null
          ? Map<String, String>.from(json['name'] as Map)
          : {},
      description: json['description'] != null
          ? Map<String, String>.from(json['description'] as Map)
          : null,
      color: json['color'] as String?,
      icon: json['icon'] as String?,
      extras: Map.fromEntries(
        json.entries.where((e) => !knownKeys.contains(e.key)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'dele_level': deleLevel,
      'order': order,
      'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      ...extras,
    };
  }

  /// 로케일에 맞는 이름 (fallback: en -> ko -> id)
  String getName(String locale) {
    return name[locale] ?? name['en'] ?? name['ko'] ?? id;
  }

  /// 로케일에 맞는 설명
  String? getDescription(String locale) {
    if (description == null) return null;
    return description![locale] ?? description!['en'] ?? description!['ko'];
  }

  /// hex 색상 -> Color
  Color? get themeColor {
    if (color == null) return null;
    final hex = color!.replaceFirst('#', '');
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Level && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Level($id, $categoryId, $deleLevel)';
}
