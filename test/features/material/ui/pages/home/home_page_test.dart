import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';
import 'package:flutterfly/features/material/ui/widgets/navbar.dart';

final class MockPlatform extends Mock implements Platform {}

final class MockMaterialService extends Mock implements MaterialService {}

void main() {
  group('HomePage', () {
    setUp(() {
      GetIt.I.registerSingleton<Platform>(MockPlatform());
      GetIt.I.registerSingleton<MaterialService>(MockMaterialService());

      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);
    });

    patrolWidgetTest('render page successfully', (final $) async {
      when(() => GetIt.I<Platform>().isMacOS).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const MaterialApp(
          home: Scaffold(
            body: HomePage(secondChild: SizedBox()),
          ),
        ),
      );

      expect($(NavBar), findsOneWidget);
      expect($(OrientationBuilder), findsOneWidget);
      expect($(Expanded), findsNWidgets(2));
      expect($(TopContent), findsOneWidget);
      expect($(BottomContent), findsOneWidget);
    });
  });
}
