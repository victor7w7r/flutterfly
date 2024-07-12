// ignore_for_file: avoid-non-null-assertion
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfly/features/common/ui/widgets/animated_gradient.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

void main() {
  group('AnimatedGradient', () {
    patrolWidgetTest('AnimatedGradient initializes with correct initial colors',
        (final $) async {
      await $.pumpWidget(const MaterialApp(home: AnimatedGradient()));

      final animatedContainerFinder = find.byType(AnimatedContainer);
      final animatedContainer =
          $.tester.widget<AnimatedContainer>(animatedContainerFinder);
      final gradient = (animatedContainer.decoration! as BoxDecoration)
          .gradient! as LinearGradient;

      await $.pump(Duration.zero);

      expect(gradient.colors.first, const Color.fromRGBO(63, 63, 70, 1));
      expect(gradient.colors[1], const Color.fromRGBO(253, 186, 116, 1));
    });

    patrolWidgetTest('AnimatedGradient changes colors after animation ends',
        (final $) async {
      await $.pumpWidget(const MaterialApp(home: AnimatedGradient()));

      final animatedContainerFinder = find.byType(AnimatedContainer);

      for (var i = 0; i < 80; i++) {
        await $.pump(const Duration(milliseconds: 100));
      }

      final animatedContainer =
          $.tester.widget<AnimatedContainer>(animatedContainerFinder);
      final gradient = (animatedContainer.decoration! as BoxDecoration)
          .gradient! as LinearGradient;

      expect(gradient.colors.first, isNot(const Color.fromRGBO(63, 63, 70, 1)));
      expect(gradient.colors[1], isNot(const Color.fromRGBO(253, 186, 116, 1)));
    });
  });
}
