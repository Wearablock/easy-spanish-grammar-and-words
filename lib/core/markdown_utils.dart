import 'package:markdown/markdown.dart' as md;

/// Bold that does not care what sits around the `**`.
///
/// CommonMark only closes `**` after punctuation when a space or punctuation follows, so
/// `**여성(femenino)**으로` or `**¿Aló?**를` stayed raw on screen (1.5.0, 10-30). This syntax runs
/// before the default emphasis rules and turns any `**…**` pair on one line into bold. Pass it to
/// every MarkdownBody as `inlineSyntaxes: markdownInlineSyntaxes`.
class BoldSyntax extends md.InlineSyntax {
  BoldSyntax() : super(r'\*\*(?!\s)((?:[^*\n]|\*(?!\*))+?)(?<!\s)\*\*');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final inner = md.InlineParser(match[1]!, parser.document).parse();
    parser.addNode(md.Element('strong', inner));
    return true;
  }
}

final List<md.InlineSyntax> markdownInlineSyntaxes = [BoldSyntax()];

/// Fixes markdown bold syntax that breaks when Korean (or other CJK)
/// characters are directly adjacent to ** delimiters.
///
/// CommonMark parsers may fail to recognize closing ** when followed
/// immediately by Unicode letters (e.g., **여자**로 renders as raw **).
/// This inserts a zero-width space to ensure proper parsing.
String fixMarkdownBold(String markdown) {
  const cjk = r'[\uAC00-\uD7AF\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF]';

  // Case 1: Both sides — [CJK]**content**[CJK] (must run first)
  markdown = markdown.replaceAllMapped(
    RegExp('($cjk)\\*\\*(.+?)\\*\\*($cjk)'),
    (m) => '${m[1]}\u200B**${m[2]}**\u200B${m[3]}',
  );

  // Case 2: Closing side only — **content**[CJK]
  markdown = markdown.replaceAllMapped(
    RegExp('\\*\\*(.+?)\\*\\*($cjk)'),
    (m) => '**${m[1]}**\u200B${m[2]}',
  );

  // Case 3: Opening side only — [CJK]**content**
  markdown = markdown.replaceAllMapped(
    RegExp('($cjk)\\*\\*(.+?)\\*\\*'),
    (m) => '${m[1]}\u200B**${m[2]}**',
  );

  return markdown;
}
