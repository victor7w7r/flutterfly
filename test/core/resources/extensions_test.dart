import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/core/resources/extensions.dart';

void main() {
  group('extensions', () {
    testWidgets('mWidth returns correct width', (final tester) async {
      var width = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              width = context.mWidth;
              return Container();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(width, 800);
    });

    testWidgets('mHeight returns correct height', (final tester) async {
      var height = 0.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              height = context.mHeight;
              return Container();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(height, 600);
    });

    testWidgets('isMaxMd returns correct value', (final tester) async {
      var isMaxMd = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMaxMd = context.isMaxMd;
              return Container();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(isMaxMd, true);
    });

    testWidgets('isMinMd returns correct value', (final tester) async {
      var isMinMd = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMinMd = context.isMinMd;
              return Container();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(isMinMd, false);
    });

    testWidgets('isMaxLg returns correct value', (final tester) async {
      var isMaxLg = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMaxLg = context.isMaxLg;
              return Container();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(isMaxLg, false);
    });

    testWidgets('isMaxResp returns correct value', (final tester) async {
      var isMaxResp = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMaxResp = context.isMaxResp;
              return Container();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(isMaxResp, false);
    });

    testWidgets('isBRatio returns correct value', (final tester) async {
      var isBRatio = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isBRatio = context.isBRatio;
              return Container();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(isBRatio, true);
    });

    testWidgets('isMRatio returns correct value', (final tester) async {
      var isMRatio = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMRatio = context.isMRatio;
              return Container();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(isMRatio, true);
    });
  });
}
