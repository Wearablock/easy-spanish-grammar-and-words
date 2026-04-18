import 'dart:convert';

import 'package:flutter/services.dart';

/// 변형 카드의 종류 — UI에서 라벨을 l10n으로 렌더링할 때 사용.
///
/// - `phrase`: 관용 표현/인사/비인칭 구문처럼 주어·부정·의문 변형이 무의미한
///   단일 표현을 담기 위한 kind. subject/nounSwap 없이 자립적인 문장.
enum VariationKind {
  base,
  subject,
  negative,
  interrogative,
  nounSwap,
  phrase,
}

VariationKind _kindFromString(String s) {
  switch (s) {
    case 'base':
      return VariationKind.base;
    case 'subject':
      return VariationKind.subject;
    case 'negative':
      return VariationKind.negative;
    case 'interrogative':
      return VariationKind.interrogative;
    case 'nounSwap':
      return VariationKind.nounSwap;
    case 'phrase':
      return VariationKind.phrase;
    default:
      throw ArgumentError('Unknown VariationKind: $s');
  }
}

/// locale fallback 체인: locale → lang → en → ko → 첫 항목.
String? _pickLocale(Map<String, String> map, String locale) {
  if (map.containsKey(locale)) return map[locale];
  final lang = locale.split('_').first;
  if (map.containsKey(lang)) return map[lang];
  if (map.containsKey('en')) return map['en'];
  if (map.containsKey('ko')) return map['ko'];
  return map.values.isEmpty ? null : map.values.first;
}

/// 씨앗(Seed) 문장 — JSON 1건 매핑.
class SpeakingSeed {
  final String id;
  final String level;
  final String verb; // ser | estar | tener | gustar
  final Map<String, String> title;
  final String baseIpa;
  final List<SpeakingCard> cards;

  SpeakingSeed({
    required this.id,
    required this.level,
    required this.verb,
    required this.title,
    required this.baseIpa,
    required this.cards,
  });

  String titleFor(String locale) =>
      _pickLocale(title, locale) ?? title.values.first;

  /// 베이스 카드(첫 카드)의 Spanish 텍스트.
  String get baseEs => cards.first.es;

  /// 베이스 카드의 현지어 번역.
  String baseTranslationFor(String locale) =>
      cards.first.translationFor(locale);

  factory SpeakingSeed.fromJson(Map<String, dynamic> j) {
    return SpeakingSeed(
      id: j['id'] as String,
      level: j['level'] as String,
      verb: j['verb'] as String,
      title: Map<String, String>.from(j['title'] as Map),
      baseIpa: j['base_ipa'] as String,
      cards: (j['cards'] as List)
          .map((e) =>
              SpeakingCard.fromJson(j['id'] as String, e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 한 카드에 대한 발화 시도 결과.
class AttemptResult {
  final SpeakingCard card;
  final String spoken;
  final double accuracy;
  AttemptResult({
    required this.card,
    required this.spoken,
    required this.accuracy,
  });
}

/// 변형 카드 — 사용자가 발화하는 단위.
///
/// 모든 locale 번역을 직접 보유 (옵션 A: JSON 명시 번역).
class SpeakingCard {
  final String id; // seedId::key
  final String es;
  final VariationKind kind;
  final String? subjectArg; // subject 변형일 때 'tú' 등
  final String? nounArg; // nounSwap일 때 새로운 명사 (es)
  final Map<String, String> translations;

  SpeakingCard({
    required this.id,
    required this.es,
    required this.kind,
    this.subjectArg,
    this.nounArg,
    required this.translations,
  });

  /// 사용자 locale에 맞는 번역 반환.
  String translationFor(String locale) =>
      _pickLocale(translations, locale) ?? es;

  factory SpeakingCard.fromJson(String seedId, Map<String, dynamic> j) {
    return SpeakingCard(
      id: '$seedId::${j['key']}',
      es: j['es'] as String,
      kind: _kindFromString(j['kind'] as String),
      subjectArg: j['subjectArg'] as String?,
      nounArg: j['nounArg'] as String?,
      translations: Map<String, String>.from(j['tr'] as Map),
    );
  }
}

/// JSON 로더.
class SpeakingSeedLoader {
  static Future<List<SpeakingSeed>> loadAll() async {
    final raw = await rootBundle
        .loadString('assets/data/speaking/seeds_es.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['seeds'] as List;
    return list
        .map((e) => SpeakingSeed.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

/// 씨앗 → 카드 리스트 추출.
///
/// 옵션 A 도입 후: 변형은 JSON에 사전 정의되어 있으므로 단순 추출만 한다.
class VariationGenerator {
  static List<SpeakingCard> generate(SpeakingSeed seed) => seed.cards;
}
