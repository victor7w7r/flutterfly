import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/features/fluent/ui/widgets/blur_button.dart';

void main() {
  group('BlurButton', () {
    patrolWidgetTest(
        'should create with required parameters and default fontSize',
        (final $) async {
      await $.pumpWidgetAndSettle(
        FluentApp(
          home: BlurButton(
            caption: 'Test Button',
            onClick: () {},
          ),
        ),
      );

      expect($('Test Button'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (final widget) => widget is Text && widget.style?.fontSize == 14,
        ),
        findsOneWidget,
      );
    });

    patrolWidgetTest('should apply custom fontSize', (final $) async {
      const customFontSize = 18.0;
      await $.pumpWidgetAndSettle(
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

    patrolWidgetTest(
      'should trigger onClick callback when tapped',
      (final $) async => $.tester.runAsync(() async {
        var isClicked = false;
        await $.pumpWidgetAndSettle(
          FluentApp(
            home: BlurButton(
              caption: 'Clickable',
              onClick: () => isClicked = true,
            ),
          ),
        );

        await $('Clickable').tap();
        await $.pump();

        expect(isClicked, isTrue);
      }),
    );

    patrolWidgetTest('should have correct styles applied', (final $) async {
      await $.pumpWidgetAndSettle(
        FluentApp(
          home: BlurButton(
            caption: 'Styled Button',
            onClick: () {},
          ),
        ),
      );

      final filledButton = $.tester.widget<FilledButton>($(FilledButton));
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
