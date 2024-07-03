// ignore_for_file: avoid_empty_blocks

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/fluent/ui/widgets/blur_button.dart';

void main() {
  group('BlurButton', () {
    testWidgets('Should create with required parameters and default fontSize',
        (final tester) async {
      await tester.pumpWidget(
        FluentApp(
          home: BlurButton(
            caption: 'Test Button',
            onClick: () {},
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (final widget) => widget is Text && widget.style?.fontSize == 14,
        ),
        findsOneWidget,
      );
    });

    testWidgets('Should apply custom fontSize', (final tester) async {
      const customFontSize = 18.0;
      await tester.pumpWidget(
        FluentApp(
          home: BlurButton(
            caption: 'Custom Font Size',
            onClick: () {},
            fontSize: customFontSize,
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (final widget) =>
              widget is Text && widget.style?.fontSize == customFontSize,
        ),
        findsOneWidget,
      );
    });

    testWidgets('Should trigger onClick callback when tapped',
        (final tester) async {
      await tester.runAsync(() async {
        var isClicked = false;
        await tester.pumpWidget(
          FluentApp(
            home: BlurButton(
              caption: 'Clickable',
              onClick: () {
                isClicked = true;
              },
            ),
          ),
        );

        await tester.tap(find.text('Clickable'));
        await tester.pump();

        expect(isClicked, isTrue);
      });
    });

    testWidgets('Should have correct styles applied', (final tester) async {
      await tester.pumpWidget(
        FluentApp(
          home: BlurButton(
            caption: 'Styled Button',
            onClick: () {},
          ),
        ),
      );

      final filledButton =
          tester.widget<FilledButton>(find.byType(FilledButton));
      expect(
        filledButton.style?.backgroundColor?.resolve({}),
        const Color.fromRGBO(255, 255, 255, 0.4),
      );
      expect(filledButton.style?.elevation?.resolve({}), 0);
      expect(
        filledButton.style?.shape?.resolve({}),
        isA<RoundedRectangleBorder>(),
      );
    });
  });
}
