import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/material/ui/layout/material_layout.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/material/ui/pages/store/store_page.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

class MockPlatform extends Mock implements Platform {}

class MockMaterialService extends Mock implements MaterialService {}

void main() {
  group('MaterialLayout', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
      GetIt.I.registerSingleton<Platform>(Platform());
    });

    testWidgets('Render widget successfully', (final tester) async {
      await tester.runAsync(() async {
        final service = GetIt.I<MaterialService>();

        when(service.isDark).thenReturn(false);

        await tester.pumpWidget(const MaterialLayout(child: SizedBox()));

        expect(find.byType(MaterialApp), findsOneWidget);
        expect(find.byType(SizedBox), findsWidgets);

        reset(service);

        when(service.isDark).thenReturn(false);

        await tester.pumpWidget(const MaterialLayout(child: SizedBox()));

        verify(service.isDark).called(1);
      });
    });

    testWidgets('Navigate to Store Page', (final tester) async {
      final service = GetIt.I<MaterialService>();

      when(service.isDark).thenReturn(false);

      await tester.runAsync(() async {
        await tester.pumpWidget(const MaterialLayout(child: SizedBox()));

        expect(find.byType(HomePage), findsOneWidget);
        expect(find.byType(StorePage), findsNothing);

        final BuildContext context = tester.element(find.byType(HomePage));
        unawaited(Navigator.pushNamed(context, '/store'));

        await tester.pumpAndSettle();

        expect(find.byType(StorePage), findsOneWidget);
      });
    });
  });
}
