import 'dart:convert';
import 'dart:io';

import 'package:easy_spanish_grammar_and_words/data/models/question.dart';
import 'package:easy_spanish_grammar_and_words/features/study/speaking/speak_target.dart';
import 'package:flutter_test/flutter_test.dart';

Question _q(String type, String question, String correct, {String? dir}) =>
    Question(
      id: 'x',
      topicId: 't',
      order: 1,
      difficulty: 1,
      type: QuestionType.fromString(type),
      translationDir: TranslationDirection.fromString(dir),
      question: question,
      correct: correct,
      wrong: const [],
      explanation: '',
    );

void main() {
  test('each question type picks its Spanish sentence', () {
    expect(
      speakTarget(
        _q('fill_blank', 'Yo ___ un café, por favor. (pedir, e→i)', 'pido'),
      ),
      'Yo pido un café, por favor.',
    );
    expect(
      speakTarget(
        _q(
          'conjugation',
          'Estas son las montañas ___ altas ___ Europa. (superlative)',
          'más, de',
        ),
      ),
      'Estas son las montañas más altas de Europa.',
    );
    expect(
      speakTarget(
        _q(
          'fill_blank',
          '¿Me das el libro? — Sí, ___ ___ doy. (IOP + DOP)',
          'te lo',
        ),
      ),
      '¿Me das el libro? — Sí, te lo doy.',
    );
    expect(
      speakTarget(
        _q(
          'meaning',
          'When do we use the preterite tense in Spanish?',
          'For completed actions',
        ),
      ),
      isNull,
    );
    expect(
      speakTarget(
        _q('translation', 'I am glad.', 'Me alegro.', dir: 'ko_to_es'),
      ),
      'Me alegro.',
    );
    expect(
      speakTarget(
        _q(
          'translation',
          'Quiero el libro.',
          'I want the book.',
          dir: 'es_to_ko',
        ),
      ),
      'Quiero el libro.',
    );
    expect(
      speakTarget(_q('meaning', "What does 'propina' mean?", 'tip')),
      'propina',
    );
    expect(
      speakTarget(
        _q(
          'meaning',
          "What does 'pizarra' mean in 'El profesor escribe en la pizarra'?",
          'board',
        ),
      ),
      'El profesor escribe en la pizarra',
    );
    expect(
      speakTarget(
        _q(
          'context',
          'You need a pen. What do you say?',
          '¿Me prestas un bolígrafo?',
        ),
      ),
      '¿Me prestas un bolígrafo?',
    );
  });

  // 실제 데이터 전부 — 말할 것이 없는 문제 수를 잰다(늘면 데이터가 새 모양이라는 신호)
  test('real English data: almost every question has something to say', () {
    final meta = <String, Map<String, dynamic>>{};
    for (final f in Directory(
      'assets/data/questions/meta',
    ).listSync().whereType<File>()) {
      final src = f.readAsStringSync();
      if (!f.path.endsWith('.json') || src.trim().isEmpty) continue;
      final j = jsonDecode(src);
      if (j is! Map || j['questions'] is! List) continue;
      for (final m in (j['questions'] as List)) {
        meta[m['id'] as String] = m as Map<String, dynamic>;
      }
    }
    var total = 0, none = 0;
    final misses = <String>[];
    for (final f in Directory(
      'assets/data/questions/en',
    ).listSync().whereType<File>()) {
      final src = f.readAsStringSync();
      if (!f.path.endsWith('.json') || src.trim().isEmpty) continue;
      final d = jsonDecode(src);
      if (d is! Map) continue;
      d.forEach((id, c) {
        final m = meta[id];
        if (m == null || c is! Map) return;
        total++;
        final t = speakTarget(
          _q(
            m['type'] as String,
            c['question'] as String,
            c['correct'] as String,
            dir: m['translation_dir'] as String?,
          ),
        );
        if (t == null) {
          none++;
          if (misses.length < 15) misses.add('$id ${c['question']}');
        }
      });
    }
    // ignore: avoid_print
    print(
      'speakTarget: $total questions · no target $none\n${misses.join('\n')}',
    );
    expect(total, greaterThan(1500));
    // 남는 것 = 영어로 문법을 묻는 «뜻» 문제(말할 스페인어가 없다 · 상자를 안 띄우는 게 맞다)
    expect(none / total, lessThan(0.035));
  });
}
