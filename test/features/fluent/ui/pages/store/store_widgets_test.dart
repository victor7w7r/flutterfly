import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/fluent/ui/pages/store/store_widgets.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';

void main() {
  group('StoreText Widget Tests', () {
    late TextEditingController controller;
    late FluentThemeApp mockTheme;

    setUp(() {
      controller = TextEditingController();
      mockTheme = FluentThemeApp.dark();
    });

    testWidgets('StoreText renders successfully', (final tester) async {
      await tester.pumpWidget(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      expect(find.byType(StoreText), findsOneWidget);
    });

    testWidgets('StoreText has correct placeholder', (final tester) async {
      await tester.pumpWidget(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      expect(find.text('here'), findsOneWidget);
    });

    testWidgets('TextBox uses correct style from theme', (final tester) async {
      await tester.pumpWidget(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      final textBox = tester.widget<TextBox>(find.byType(TextBox));
      expect(textBox.style?.color, equals(Colors.white));
    });

    testWidgets('TextBox cursor color matches theme', (final tester) async {
      await tester.pumpWidget(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      final textBox = tester.widget<TextBox>(find.byType(TextBox));
      expect(textBox.cursorColor, equals(Colors.white));
    });

    testWidgets('TextBox decoration color matches theme', (final tester) async {
      await tester.pumpWidget(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      final textBox = tester.widget<TextBox>(find.byType(TextBox));
      expect(
        textBox.decoration?.color,
        equals(const Color.fromARGB(255, 42, 52, 68)),
      );
    });
  });
}
