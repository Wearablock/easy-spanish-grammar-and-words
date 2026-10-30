// Renders every theory and explanation the way the app does (fixMarkdownBold → MarkdownBody's
// default GitHub-flavored parser) and reports any `**` still showing as raw text.
//
//   dart run tool/check_bold.dart            list problems, exit 1 if any
//
// publish.py runs this before uploading — a broken bold in the data never reaches users again (10-31).
import 'dart:convert';
import 'dart:io';

import 'package:easy_spanish_grammar_and_words/core/markdown_utils.dart';
import 'package:markdown/markdown.dart' as md;

final _tags = RegExp(r'<[^>]+>');
// `p***` masks a word on purpose — not a broken bold
final _mask = RegExp(r'\w\*{3,}');

int leftover(String text) {
  final html = md.markdownToHtml(fixMarkdownBold(text), extensionSet: md.ExtensionSet.gitHubFlavored);
  final plain = html.replaceAll(_tags, '').replaceAll(_mask, '');
  return '**'.allMatches(plain).length;
}

void main() {
  final root = Directory('assets/data');
  var bad = 0;
  for (final f in root.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.json'))) {
    final rel = f.path.substring(root.path.length + 1);
    if (!rel.startsWith('topics/topics_') && !rel.startsWith('questions/')) continue;
    final data = jsonDecode(f.readAsStringSync());
    if (data is! Map) continue;
    data.forEach((id, item) {
      if (item is! Map) return;
      for (final key in ['theory', 'explanation']) {
        final text = item[key];
        if (text is! String || !text.contains('**')) continue;
        final n = leftover(text);
        if (n == 0) continue;
        bad++;
        final at = text.indexOf(RegExp(r'\*\*[^*]*?[^\s\w*]\*\*\w|\*\*\w'));
        final snip = text.substring((at - 20).clamp(0, text.length), (at + 50).clamp(0, text.length)).replaceAll('\n', ' ');
        print('❌ $rel · $id · $key · ** ×$n · …$snip…');
      }
    });
  }
  print('${bad == 0 ? '✅' : '🔴'} broken bold: $bad');
  exit(bad == 0 ? 0 : 1);
}
