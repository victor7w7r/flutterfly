import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/widgets/title_bar.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';
import 'package:flutterfly/features/material/ui/widgets/navbar.dart';

final class MockPlatform extends Mock implements Platform {}

final class MockMaterialService extends Mock
    with ChangeNotifier
    implements MaterialService {}

void main() {
  group('NavBar', () {
    setUp(() async {
      await GetIt.I.reset();

      GetIt.I.registerSingleton<Platform>(MockPlatform());
      GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
    });

    patrolWidgetTest(
        'Render AppBar successfully when macOS is the main platform',
        (final $) async {
      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);
      when(() => GetIt.I<Platform>().isMacOS).thenReturn(true);
      when(() => GetIt.I<Platform>().isDesktop).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const MaterialApp(
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(1280, 720),
              child: NavBar('Test title', child: Placeholder()),
            ),
          ),
        ),
      );

      expect($(AppBar), findsOneWidget);
      expect($(WindowTitleBar), findsOneWidget);
      expect($(Container), findsOneWidget);
      expect($(IconButton), findsOneWidget);
    });

    patrolWidgetTest(
        'Render AppBar successfully when windows is the main platform',
        (final $) async {
      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

      when(() => GetIt.I<Platform>().isMacOS).thenReturn(false);
      when(() => GetIt.I<Platform>().isDesktop).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const MaterialApp(
          home: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(1280, 720),
              child: NavBar('Test title', child: Placeholder()),
            ),
          ),
        ),
      );

      expect($(AppBar), findsOneWidget);
      expect($(WindowTitleBar), findsOneWidget);
    });
  });
}
