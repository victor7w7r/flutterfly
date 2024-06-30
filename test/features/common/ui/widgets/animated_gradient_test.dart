import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutterfly/features/common/ui/widgets/animated_gradient.dart';

void main() {
  group('AnimatedGradient', () {
    testWidgets('AnimatedGradient initializes with correct initial colors',
        (final tester) async {
      await tester.pumpWidget(const MaterialApp(home: AnimatedGradient()));

      final animatedContainerFinder = find.byType(AnimatedContainer);
      final animatedContainer =
          tester.widget<AnimatedContainer>(animatedContainerFinder);
      final gradient = (animatedContainer.decoration! as BoxDecoration)
          .gradient! as LinearGradient;

      await tester.pump(Duration.zero);

      expect(gradient.colors.first, const Color.fromRGBO(63, 63, 70, 1));
      expect(gradient.colors[1], const Color.fromRGBO(253, 186, 116, 1));
    });

    testWidgets('AnimatedGradient changes colors after animation ends',
        (final tester) async {
      await tester.pumpWidget(const MaterialApp(home: AnimatedGradient()));

      final animatedContainerFinder = find.byType(AnimatedContainer);

      for (var i = 0; i < 80; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }

      final animatedContainer =
          tester.widget<AnimatedContainer>(animatedContainerFinder);
      final gradient = (animatedContainer.decoration! as BoxDecoration)
          .gradient! as LinearGradient;

      expect(gradient.colors.first, isNot(const Color.fromRGBO(63, 63, 70, 1)));
      expect(gradient.colors[1], isNot(const Color.fromRGBO(253, 186, 116, 1)));
    });
  });
}
