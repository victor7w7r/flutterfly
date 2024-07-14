import 'dart:async' show unawaited;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/fluent/ui/layout/fluent_layout.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/fluent/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';

final class MockPlatform extends Mock implements Platform {}

final class MockFluentService extends Mock implements FluentService {}

void main() {
  group('FluentLayout', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<FluentService>(MockFluentService());

      when(() => GetIt.I<FluentService>().state)
          .thenReturn(FluentThemeApp.dark());
    });

    patrolWidgetTest(
      'render widget successfully',
      (final $) async => $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const FluentLayout(child: SizedBox()));

        final widget = $.tester.widget<FluentApp>($(FluentApp));

        expect($(FluentApp), findsOneWidget);
        expect(widget.color, GetIt.I<FluentService>().state.themeColor.first);
      }),
    );

    patrolWidgetTest(
      'navigate to Store Page',
      (final $) async => $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const FluentLayout(child: SizedBox()));

        expect($(HomePage), findsOneWidget);
        expect($(StorePage), findsNothing);

        final BuildContext context = $.tester.element($(HomePage));
        unawaited(Navigator.pushNamed(context, '/store'));

        await $.pumpAndSettle();

        expect($(StorePage), findsOneWidget);
      }),
    );
  });
}
