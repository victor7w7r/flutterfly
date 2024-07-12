import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/features/common/ui/pages/desktop_selector_widgets.dart';

void main() {
  group('DesktopSelectorWidgets', () {
    patrolWidgetTest('MenuBuilder creates correctly with required parameters',
        (final $) async {
      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: MenuBuilder(
            title: 'Test Title',
            image: 'fluent',
            onTap: () {},
          ),
        ),
      );

      expect($(MenuBuilder), findsOneWidget);
    });

    patrolWidgetTest('Title displays correctly', (final $) async {
      const testTitle = 'Test Title';
      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: MenuBuilder(
            title: testTitle,
            image: 'fluent',
            onTap: () {},
          ),
        ),
      );

      expect($(testTitle), findsOneWidget);
    });

    patrolWidgetTest('Image displays correctly', (final $) async {
      const testImage = 'fluent';
      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: MenuBuilder(
            title: 'Test Title',
            image: testImage,
            onTap: () {},
          ),
        ),
      );

      expect($(Image), findsOneWidget);
    });

    patrolWidgetTest('Tap on image triggers onTap callback', (final $) async {
      var isTapped = false;
      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: MenuBuilder(
            title: 'Test Title',
            image: 'fluent',
            onTap: () {
              isTapped = true;
            },
          ),
        ),
      );

      await $(GestureDetector).tap();
      await $.pump();

      expect(isTapped, isTrue);
    });
  });
}
