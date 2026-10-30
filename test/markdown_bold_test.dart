import 'package:easy_spanish_grammar_and_words/core/markdown_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markdown/markdown.dart' as md;

// Renders like MarkdownBody does in the app (fixMarkdownBold → GitHub-flavored + BoldSyntax).
String render(String s) => md.markdownToHtml(
      fixMarkdownBold(s),
      extensionSet: md.ExtensionSet.gitHubFlavored,
      inlineSyntaxes: markdownInlineSyntaxes,
    ).replaceAll('​', '').trim();

void main() {
  // The 1.5.0 data that showed raw ** on a real device (10-30, IMG_3352)
  test('bold closes after punctuation followed by a letter', () {
    expect(render('**여성(femenino)**으로'), '<p><strong>여성(femenino)</strong>으로</p>');
    expect(render('**¿Aló?**를'), '<p><strong>¿Aló?</strong>를</p>');
    expect(render('**男性名詞（masculino）**か'), '<p><strong>男性名詞（masculino）</strong>か</p>');
  });

  test('bold opens right after a word', () {
    expect(render('ciudades**:** Madrid'), '<p>ciudades<strong>:</strong> Madrid</p>');
  });

  test('inline markup inside bold still works', () {
    expect(render('**\\*Le lo** doy'), '<p><strong>*Le lo</strong> doy</p>');
    expect(render('**el *día* largo**'), '<p><strong>el <em>día</em> largo</strong></p>');
  });

  test('single * and masks are left alone', () {
    expect(render('*siguo*'), '<p><em>siguo</em></p>');
    expect(render('p*** word'), '<p>p*** word</p>');
    expect(render('2 ** 3'), '<p>2 ** 3</p>');
  });

  test('ordinary bold is unchanged', () {
    expect(render('**IOP + DOP**입니다'), '<p><strong>IOP + DOP</strong>입니다</p>');
    expect(render('| **mi** | **mis** |\n|---|---|\n| a | b |'), contains('<strong>mi</strong>'));
  });
}
