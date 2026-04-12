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
