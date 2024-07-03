import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/widgets/title_bar.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';
import 'package:flutterfly/features/material/ui/widgets/navbar.dart';

class MockPlatform extends Mock implements Platform {}

class MockMaterialService extends Mock
    with ChangeNotifier
    implements MaterialService {}

void main() {
  group('NavBar', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<Platform>(MockPlatform());
      GetIt.I.registerLazySingleton<MaterialService>(MockMaterialService.new);
    });

    testWidgets('Render AppBar successfully when macOS is the main platform',
        (final tester) async {
      final service = GetIt.I.get<MaterialService>();
      when(service.isDark).thenReturn(false);

      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(true);
      when(platform.isDesktop).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(1280, 720),
              child: NavBar('Test title', child: Placeholder()),
            ),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(WindowTitleBar), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('Render AppBar successfully when windows is the main platform',
        (final tester) async {
      final service = GetIt.I.get<MaterialService>();
      when(service.isDark).thenReturn(false);

      final platform = GetIt.I.get<Platform>();
      when(platform.isMacOS).thenReturn(false);
      when(platform.isDesktop).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(1280, 720),
              child: NavBar('Test title', child: Placeholder()),
            ),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(WindowTitleBar), findsOneWidget);
    });
  });
}
