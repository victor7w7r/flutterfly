import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/features/material/ui/services/material_service.dart';
import 'package:flutterfly/features/material/ui/widgets/drawer_menu.dart';

final class MockMaterialService extends Mock
    with ChangeNotifier
    implements MaterialService {}

void main() {
  group('DrawerMenu', () {
    setUp(() async {
      await GetIt.I.reset();

      GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
    });

    patrolWidgetTest('Drawer builds correctly with dark and light mode',
        (final $) async {
      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

      await $.pumpWidgetAndSettle(
        const MaterialApp(
          home: Scaffold(body: DrawerMenu()),
        ),
      );

      expect($(Drawer), findsOneWidget);
      expect($(Column), findsOneWidget);
      expect($(Spacer), findsWidgets);

      when(() => GetIt.I<MaterialService>().isDark).thenReturn(true);

      await $.pumpWidgetAndSettle(
        const MaterialApp(
          home: Scaffold(body: DrawerMenu()),
        ),
      );

      expect($(Drawer), findsOneWidget);
      expect($(Column), findsOneWidget);
      expect($(Spacer), findsWidgets);
    });

    patrolWidgetTest('Drawer tap on Home item and navigate', (final $) async {
      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: const Scaffold(body: Placeholder(), drawer: DrawerMenu()),
          routes: {
            '/store': (final _) => const Text('Store'),
          },
        ),
      );
      final scaffoldState = $.tester.firstState<ScaffoldState>($(Scaffold));
      // ignore: cascade_invocations
      scaffoldState.openDrawer();
      await $.pumpAndSettle();

      await $.tap(find.widgetWithText(ListTile, 'Home'));
      await $.pumpAndSettle();

      expect($(Placeholder), findsOneWidget);
    });

    patrolWidgetTest('Drawer tap on Store item and navigate', (final $) async {
      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

      await $.pumpWidgetAndSettle(
        MaterialApp(
          home: const Scaffold(body: Placeholder(), drawer: DrawerMenu()),
          routes: {
            '/store': (final _) => const Text('Store'),
          },
        ),
      );
      final scaffoldState = $.tester.firstState<ScaffoldState>($(Scaffold));
      // ignore: cascade_invocations
      scaffoldState.openDrawer();
      await $.pumpAndSettle();

      await $.tap(find.widgetWithText(ListTile, 'Store'));
      await $.pumpAndSettle();

      expect($('Store'), findsOneWidget);
    });

    patrolWidgetTest('Tapping the switch calls toggle', (final $) async {
      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

      await $.pumpWidgetAndSettle(
        const MaterialApp(
          home: Scaffold(
            body: Placeholder(),
            drawer: DrawerMenu(),
          ),
        ),
      );
      final scaffoldState = $.tester.firstState<ScaffoldState>($(Scaffold));
      // ignore: cascade_invocations
      scaffoldState.openDrawer();
      await $.pumpAndSettle();

      await $.tap(find.widgetWithText(ListTile, 'Change Color Mode'));
      await $.pumpAndSettle();

      verify(GetIt.I<MaterialService>().toggle).called(1);
    });
  });
}
