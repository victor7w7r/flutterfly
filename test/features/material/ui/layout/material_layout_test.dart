import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/material/ui/layout/material_layout.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/material/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

final class MockPlatform extends Mock implements Platform {}

final class MockMaterialService extends Mock implements MaterialService {}

void main() {
  group('MaterialLayout', () {
    setUp(() async {
      await GetIt.I.reset();

      GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
      GetIt.I.registerSingleton(Platform());
    });

    patrolWidgetTest('render widget successfully', (final $) async {
      final service = GetIt.I<MaterialService>();
      when(() => service.isDark).thenReturn(false);

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const MaterialLayout(child: SizedBox()));

        expect($(MaterialApp), findsOneWidget);
        expect($(SizedBox), findsWidgets);

        reset(service);

        when(() => service.isDark).thenReturn(false);

        await $.pumpWidgetAndSettle(const MaterialLayout(child: SizedBox()));

        verify(() => service.isDark).called(1);
      });
    });

    patrolWidgetTest('navigate to Store Page', (final $) async {
      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const MaterialLayout(child: SizedBox()));

        expect($(HomePage), findsOneWidget);
        expect($(StorePage), findsNothing);

        final BuildContext context = $.tester.element($(HomePage));
        unawaited(Navigator.pushNamed(context, '/store'));

        await $.pumpAndSettle();

        expect($(StorePage), findsOneWidget);
      });
    });
  });
}
