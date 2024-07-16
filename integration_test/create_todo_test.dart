import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_list/main_dev.dart' as app;

void main() {
  testWidgets(
      'Создание дела без приоритета и дедлайна путем перехода на экран создания',
      (tester) async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    app.main();
    await tester.pumpAndSettle();

    final createTodoButtonFinder = find.byIcon(Icons.add);
    expect(createTodoButtonFinder, findsOneWidget);
    await tester.tap(createTodoButtonFinder);
    await tester.pumpAndSettle();

    final textFieldFinder = find.byKey(const Key('todoTextField'));
    expect(textFieldFinder, findsOneWidget);
    await tester.enterText(textFieldFinder, '🤖 integration test todo 🤖');
    await tester.pumpAndSettle();

    final saveButtonFinder = find.byKey(const Key('saveButton'));
    expect(saveButtonFinder, findsOneWidget);
    await tester.tap(saveButtonFinder);
    await tester.pumpAndSettle();
  });
}
