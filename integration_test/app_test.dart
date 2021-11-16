import 'package:contact_test/app/modules/home/controllers/home_controller.dart';
import 'package:contact_test/main.dart' as app;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('app test', () {
    testWidgets('full app test', (tester) async {
      app.main();

      await tester.pumpAndSettle();

      final controller = HomeController();

      expect(controller.listContacts, []);

      await tester.pumpAndSettle();

      final add = find.byType(IconButton);

      await tester.tap(add);

      await tester.pumpAndSettle();

      final nameField = find.byKey(const Key('name'));
      final emailField = find.byKey(const Key('email'));
      final phoneield = find.byKey(const Key('phone'));
      final noteField = find.byKey(const Key('note'));
      final saveButton = find.byType(ElevatedButton);

      await tester.enterText(nameField, 'Ronaldo');
      await tester.enterText(emailField, 'Ronaldo@gmail.com');
      await tester.enterText(phoneield, '08976549733');
      await tester.enterText(noteField, 'notes');

      await tester.pumpAndSettle();

      await tester.tap(saveButton);

      await tester.pumpAndSettle();
    });
  });
}
