import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';
import 'package:flutterfly/features/material/ui/widgets/navbar.dart';

class MockPlatform extends Mock implements Platform {}

class MockMaterialService extends Mock implements MaterialService {}

void main() {
  group('HomePage', () {
    setUp(() {
      GetIt.I.registerSingleton<Platform>(MockPlatform());
      GetIt.I.registerSingleton<MaterialService>(MockMaterialService());

      when(() => GetIt.I.get<MaterialService>().isDark()).thenReturn(false);
    });

    testWidgets('Render page successfully', (final tester) async {
      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HomePage(secondChild: SizedBox()),
          ),
        ),
      );

      expect(find.byType(NavBar), findsOneWidget);
      expect(find.byType(OrientationBuilder), findsOneWidget);
      expect(find.byType(Expanded), findsNWidgets(2));
      expect(find.byType(TopContent), findsOneWidget);
      expect(find.byType(BottomContent), findsOneWidget);
    });
  });
}
