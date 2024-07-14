import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

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

    patrolWidgetTest('StoreText renders successfully', (final $) async {
      await $.pumpWidgetAndSettle(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      expect($(StoreText), findsOneWidget);
    });

    patrolWidgetTest('StoreText has correct placeholder', (final $) async {
      await $.pumpWidgetAndSettle(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      expect($('here'), findsOneWidget);
    });

    patrolWidgetTest('TextBox uses correct style from theme', (final $) async {
      await $.pumpWidgetAndSettle(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      expect(
        $.tester.widget<TextBox>($(TextBox)).style?.color,
        equals(Colors.white),
      );
    });

    patrolWidgetTest('TextBox cursor color matches theme', (final $) async {
      await $.pumpWidgetAndSettle(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      expect(
        $.tester.widget<TextBox>($(TextBox)).cursorColor,
        equals(Colors.white),
      );
    });

    patrolWidgetTest('TextBox decoration color matches theme', (final $) async {
      await $.pumpWidgetAndSettle(
        FluentApp(
          home: StoreText(ctl: controller, theme: mockTheme),
        ),
      );
      expect(
        $.tester.widget<TextBox>($(TextBox)).decoration?.color,
        equals(const Color.fromARGB(255, 42, 52, 68)),
      );
    });
  });
}
