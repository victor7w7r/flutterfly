// ignore_for_file: avoid_empty_blocks

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/ui/pages/desktop_selector_widgets.dart';

void main() {
  group('DesktopSelectorWidgets', () {
    testWidgets('MenuBuilder creates correctly with required parameters',
        (final tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MenuBuilder(
            title: 'Test Title',
            image: 'fluent',
            onTap: () {},
          ),
        ),
      );

      expect(find.byType(MenuBuilder), findsOneWidget);
    });

    testWidgets('Title displays correctly', (final tester) async {
      const testTitle = 'Test Title';
      await tester.pumpWidget(
        MaterialApp(
          home: MenuBuilder(
            title: testTitle,
            image: 'fluent',
            onTap: () {},
          ),
        ),
      );

      expect(find.text(testTitle), findsOneWidget);
    });

    testWidgets('Image displays correctly', (final tester) async {
      const testImage = 'fluent';
      await tester.pumpWidget(
        MaterialApp(
          home: MenuBuilder(
            title: 'Test Title',
            image: testImage,
            onTap: () {},
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('Tap on image triggers onTap callback', (final tester) async {
      var isTapped = false;
      await tester.pumpWidget(
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

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(isTapped, isTrue);
    });
  });
}
