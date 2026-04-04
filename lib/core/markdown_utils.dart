/// Fixes markdown bold syntax that breaks when Korean (or other CJK)
/// characters are directly adjacent to ** delimiters.
///
/// CommonMark parsers may fail to recognize closing ** when followed
/// immediately by Unicode letters (e.g., **여자**로 renders as raw **).
/// This inserts a zero-width space to ensure proper parsing.
String fixMarkdownBold(String markdown) {
  // Insert zero-width space between closing ** and adjacent Korean/CJK chars
  // Matches: **content**[Korean/CJK char]
  markdown = markdown.replaceAllMapped(
    RegExp(r'\*\*(.+?)\*\*([\uAC00-\uD7AF\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF])'),
    (m) => '**${m[1]}**\u200B${m[2]}',
  );

  // Insert zero-width space between adjacent Korean/CJK char and opening **
  // Matches: [Korean/CJK char]**content**
  markdown = markdown.replaceAllMapped(
    RegExp(r'([\uAC00-\uD7AF\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF])\*\*(.+?)\*\*'),
    (m) => '${m[1]}\u200B**${m[2]}**',
  );

  return markdown;
}
