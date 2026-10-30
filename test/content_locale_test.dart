import 'dart:ui';

import 'package:easy_spanish_grammar_and_words/core/config/setting_keys.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // «System» language must follow the device for every content language (1.5.1)
  test('device language picks its content language', () {
    expect(LanguageOption.contentLocaleFor(const Locale('ko')), 'ko');
    expect(LanguageOption.contentLocaleFor(const Locale('fr', 'FR')), 'fr');
    expect(LanguageOption.contentLocaleFor(const Locale('ja')), 'ja');
    expect(LanguageOption.contentLocaleFor(const Locale('pt', 'BR')), 'pt');
  });

  test('Chinese splits by script and region', () {
    expect(LanguageOption.contentLocaleFor(const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans')), 'zh-Hans');
    expect(LanguageOption.contentLocaleFor(const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant')), 'zh-Hant');
    expect(LanguageOption.contentLocaleFor(const Locale('zh', 'TW')), 'zh-Hant');
    expect(LanguageOption.contentLocaleFor(const Locale('zh', 'CN')), 'zh-Hans');
  });

  test('languages we do not have fall back to English', () {
    expect(LanguageOption.contentLocaleFor(const Locale('nl')), 'en');
    expect(LanguageOption.contentLocaleFor(const Locale('pl')), 'en');
  });
}
