import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/features/common/ui/widgets/nest.dart';

void main() {
  group('Nest', () {
    patrolWidgetTest('Renders a Container for an empty NestChain list',
        (final $) async {
      await $.pumpWidgetAndSettle(MaterialApp(home: Nest(const [])));

      expect($(Container), findsOneWidget);
    });

    patrolWidgetTest('Applies a single NestChain function', (final $) async {
      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Nest([
            (final child) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: child,
                ),
          ]),
        ),
      );

      expect($(Padding), findsOneWidget);
    });

    patrolWidgetTest('Applies multiple NestChain functions in reverse order',
        (final $) async {
      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: Nest([
            (final child) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: child,
                ),
            // ignore: use_colored_box
            (final child) => Container(color: Colors.red, child: child),
          ]),
        ),
      );

      expect($(Container), findsWidgets);
    });

    patrolWidgetTest('Correctly uses the key property', (final $) async {
      final key = UniqueKey();
      await $.pumpWidgetAndSettle(MaterialApp(home: Nest(const [], key: key)));
      expect($(key), findsOneWidget);
    });
  });
}
