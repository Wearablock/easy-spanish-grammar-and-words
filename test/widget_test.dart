import 'package:flutter_test/flutter_test.dart';

import 'package:easy_spanish_grammar_and_words/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const EspanolBiteApp());
    await tester.pumpAndSettle();
  });
}
