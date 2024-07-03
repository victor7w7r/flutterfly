import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/features/material/ui/services/material_service.dart';
import 'package:flutterfly/features/material/ui/widgets/drawer_menu.dart';

class MockMaterialService extends Mock
    with ChangeNotifier
    implements MaterialService {}

void main() {
  group('DrawerMenu', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerLazySingleton<MaterialService>(MockMaterialService.new);
    });

    testWidgets('Drawer builds correctly with dark and light mode',
        (final tester) async {
      final service = GetIt.I.get<MaterialService>();
      when(service.isDark).thenReturn(false);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DrawerMenu()),
        ),
      );

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Spacer), findsWidgets);

      when(service.isDark).thenReturn(true);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: DrawerMenu()),
        ),
      );

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Spacer), findsWidgets);
    });

    testWidgets('Drawer tap on Home item and navigate', (final tester) async {
      final service = GetIt.I.get<MaterialService>();
      when(service.isDark).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: Placeholder(),
            drawer: DrawerMenu(),
          ),
          routes: {
            '/store': (final _) => const Text('Store'),
          },
        ),
      );
      final scaffoldState =
          tester.firstState<ScaffoldState>(find.byType(Scaffold));
      // ignore: cascade_invocations
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ListTile, 'Home'));
      await tester.pumpAndSettle();

      expect(find.byType(Placeholder), findsOneWidget);
    });

    testWidgets('Drawer tap on Store item and navigate', (final tester) async {
      final service = GetIt.I.get<MaterialService>();
      when(service.isDark).thenReturn(false);

      await tester.pumpWidget(
        MaterialApp(
          home: const Scaffold(
            body: Placeholder(),
            drawer: DrawerMenu(),
          ),
          routes: {
            '/store': (final _) => const Text('Store'),
          },
        ),
      );
      final scaffoldState =
          tester.firstState<ScaffoldState>(find.byType(Scaffold));
      // ignore: cascade_invocations
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ListTile, 'Store'));
      await tester.pumpAndSettle();

      expect(find.text('Store'), findsOneWidget);
    });

    testWidgets('Tapping the switch calls toggle', (final tester) async {
      final service = GetIt.I.get<MaterialService>();
      when(service.isDark).thenReturn(false);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Placeholder(),
            drawer: DrawerMenu(),
          ),
        ),
      );
      final scaffoldState =
          tester.firstState<ScaffoldState>(find.byType(Scaffold));
      // ignore: cascade_invocations
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ListTile, 'Change Color Mode'));
      await tester.pumpAndSettle();

      verify(service.toggle).called(1);
    });
  });
}
