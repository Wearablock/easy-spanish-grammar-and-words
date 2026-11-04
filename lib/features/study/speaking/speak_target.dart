import '../../../data/models/question.dart';

/// 1.6.0 «모든 문제에 말하기» — 이 문제에서 소리 내 말할 스페인어 문장 하나를 고른다.
///
/// 언어 앱마다 바꾸는 칸은 이 함수 하나다(apps/LANGUAGE-APP-COMMON.md) — 일본어 앱은 여기만 바꾼다.
/// 말할 것이 없으면 null(그 문제는 말하기 상자를 안 띄운다).
///
///   빈칸 · 활용      문제 문장에 정답을 채운 것(끝 괄호 힌트는 뺀다 · 빈칸 둘이면 «a, b» 를 차례로)
///   번역 ko→es       정답(스페인어)
///   번역 es→ko       문제 문장(스페인어)
///   뜻              문제 속 따옴표 스페인어 — 둘이면 뒤의 것(«'x' mean in '문장'» 은 문장)
///   문맥            정답(스페인어 표현)
///   순서 맞추기      정답(완성 문장)
///   듣기            문제 문장(들은 문장)
String? speakTarget(Question q) {
  final String? raw;
  switch (q.type) {
    case QuestionType.fillBlank:
    case QuestionType.conjugation:
      raw = _fill(_stripHint(q.question), q.correct);
    case QuestionType.translation:
      raw = q.translationDir == TranslationDirection.esToKo
          ? q.question
          : q.correct;
    case QuestionType.meaning:
      raw = _lastQuoted(q.question);
    case QuestionType.context:
    case QuestionType.sentenceOrder:
      raw = q.correct;
    case QuestionType.listening:
      raw = q.question;
  }
  final t = raw?.trim() ?? '';
  return t.isEmpty || t.contains('___') ? null : t;
}

final _trailingParen = RegExp(r'\s*\([^)]*\)\s*$');
final _quoted = RegExp(r"'([^']+)'");

String _stripHint(String text) => text.replaceAll(_trailingParen, '').trim();

String? _fill(String sentence, String correct) {
  if (!sentence.contains('___')) return null;
  final parts = sentence.split('___');
  final blanks = parts.length - 1;
  var answers = [correct.trim()];
  if (blanks > 1) {
    // «más, de» 처럼 쉼표로 · 없으면 «te lo» 처럼 낱말 수가 빈칸 수와 같을 때 띄어쓰기로
    answers = correct.contains(',')
        ? correct.split(',').map((s) => s.trim()).toList()
        : correct.trim().split(RegExp(r'\s+'));
  }
  if (answers.length != blanks) return null;
  final b = StringBuffer(parts.first);
  for (var i = 0; i < answers.length; i++) {
    b
      ..write(answers[i])
      ..write(parts[i + 1]);
  }
  return b.toString();
}

String? _lastQuoted(String question) {
  final m = _quoted.allMatches(question).toList();
  return m.isEmpty ? null : m.last.group(1);
}
