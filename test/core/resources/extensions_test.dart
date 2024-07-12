import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/resources/extensions.dart';

void main() {
  group('extensions', () {
    patrolWidgetTest('mWidth returns correct width', (final $) async {
      var width = 0.0;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              width = context.mWidth;

              return const SizedBox();
            },
          ),
        ),
      );
      expect(width, 800);
    });

    patrolWidgetTest('mHeight returns correct height', (final $) async {
      var height = 0.0;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              height = context.mHeight;

              return const SizedBox();
            },
          ),
        ),
      );
      expect(height, 600);
    });

    patrolWidgetTest('isMaxMd returns correct value', (final $) async {
      var isMaxMd = false;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMaxMd = context.isMaxMd;

              return Container();
            },
          ),
        ),
      );

      expect(isMaxMd, true);
    });

    patrolWidgetTest('isMinMd returns correct value', (final $) async {
      var isMinMd = false;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMinMd = context.isMinMd;

              return Container();
            },
          ),
        ),
      );

      expect(isMinMd, false);
    });

    patrolWidgetTest('isMaxLg returns correct value', (final $) async {
      var isMaxLg = false;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMaxLg = context.isMaxLg;

              return Container();
            },
          ),
        ),
      );

      expect(isMaxLg, false);
    });

    patrolWidgetTest('isMaxResp returns correct value', (final $) async {
      var isMaxResp = false;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMaxResp = context.isMaxResp;

              return Container();
            },
          ),
        ),
      );

      expect(isMaxResp, false);
    });

    patrolWidgetTest('isBRatio returns correct value', (final $) async {
      var isBRatio = false;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isBRatio = context.isBRatio;

              return Container();
            },
          ),
        ),
      );

      expect(isBRatio, true);
    });

    patrolWidgetTest('isMRatio returns correct value', (final $) async {
      var isMRatio = false;

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Builder(
            builder: (final context) {
              isMRatio = context.isMRatio;

              return Container();
            },
          ),
        ),
      );

      expect(isMRatio, true);
    });
  });
}
