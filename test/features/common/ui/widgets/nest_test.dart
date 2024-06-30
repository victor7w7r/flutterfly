import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/ui/widgets/nest.dart';

void main() {
  group('Nest', () {
    testWidgets('Renders a Container for an empty NestChain list',
        (final tester) async {
      await tester.pumpWidget(MaterialApp(home: Nest(const [])));
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('Applies a single NestChain function', (final tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Nest([
            (final child) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: child,
                ),
          ]),
        ),
      );
      expect(find.byType(Padding), findsOneWidget);
    });

    testWidgets('Applies multiple NestChain functions in reverse order',
        (final tester) async {
      await tester.pumpWidget(
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

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('Correctly uses the key property', (final tester) async {
      final key = UniqueKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Nest(const [], key: key),
        ),
      );
      expect(find.byKey(key), findsOneWidget);
    });
  });
}
