import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/app.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_controller.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_page.dart';
import 'package:flutterfly/features/common/ui/services/desktop_service.dart';
import 'package:flutterfly/features/cupertino/ui/layout/cupertino_layout.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import 'package:flutterfly/features/fluent/ui/layout/fluent_layout.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/material/ui/layout/material_layout.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';

class MockPlatform extends Mock implements Platform {}

class MockDesktopService extends Mock implements DesktopService {}

class MockCupertinoService extends Mock implements CupertinoService {}

class MockMaterialService extends Mock implements MaterialService {}

class MockFluentService extends Mock implements FluentService {}

class MockDesktopSelectorController extends Mock
    with ChangeNotifier
    implements DesktopSelectorController {}

void main() {
  group('App', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<Platform>(MockPlatform());
      GetIt.I.registerSingleton<DesktopService>(MockDesktopService());
      GetIt.I.registerSingleton<CupertinoService>(MockCupertinoService());
      GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
      GetIt.I.registerSingleton<FluentService>(MockFluentService());
      GetIt.I.registerLazySingleton<DesktopSelectorController>(
        MockDesktopSelectorController.new,
      );

      when(GetIt.I.get<CupertinoService>().isDark).thenReturn(false);
      when(GetIt.I.get<MaterialService>().isDark).thenReturn(false);
      when(GetIt.I.get<FluentService>().state)
          .thenReturn(FluentThemeApp.dark());
      when(() => GetIt.I.get<DesktopSelectorController>().isInitAnim)
          .thenReturn(false);
    });
    testWidgets('Should display CupertinoLayout for iOS platform',
        (final tester) async {
      await tester.runAsync(() async {
        final platform = GetIt.I.get<Platform>();

        when(platform.isIos).thenReturn(true);
        when(platform.isAndroid).thenReturn(false);
        when(platform.isDesktop).thenReturn(false);
        when(platform.isMacOS).thenReturn(false);

        await tester.pumpWidget(const App(child: SizedBox()));

        await tester.pump();

        expect(find.byType(CupertinoLayout), findsOneWidget);
      });
    });
    testWidgets('Should display MaterialLayout for Android platform',
        (final tester) async {
      await tester.runAsync(() async {
        final platform = GetIt.I.get<Platform>();

        when(platform.isIos).thenReturn(false);
        when(platform.isAndroid).thenReturn(true);
        when(platform.isDesktop).thenReturn(false);
        when(platform.isMacOS).thenReturn(false);

        await tester.pumpWidget(const App(child: SizedBox()));

        await tester.pump();

        expect(find.byType(MaterialLayout), findsOneWidget);
      });
    });

    testWidgets(
        'Should display MaterialLayout with for '
        'desktop platform and material state', (final tester) async {
      await tester.runAsync(() async {
        final platform = GetIt.I.get<Platform>();
        final desktopService = GetIt.I.get<DesktopService>();

        when(platform.isIos).thenReturn(false);
        when(platform.isAndroid).thenReturn(false);
        when(platform.isDesktop).thenReturn(true);
        when(desktopService.state).thenReturn('material');

        await tester.pumpWidget(const App(child: SizedBox()));

        await tester.pump();

        expect(find.byType(MaterialLayout), findsOneWidget);
      });
    });

    testWidgets(
        'Should display CupertinoLayout with for '
        'desktop platform and cupertino state', (final tester) async {
      await tester.runAsync(() async {
        final platform = GetIt.I.get<Platform>();
        final desktopService = GetIt.I.get<DesktopService>();

        when(platform.isIos).thenReturn(false);
        when(platform.isAndroid).thenReturn(false);
        when(platform.isDesktop).thenReturn(true);
        when(platform.isMacOS).thenReturn(false);
        when(desktopService.state).thenReturn('cupertino');

        await tester.pumpWidget(const App(child: SizedBox()));

        await tester.pump();

        expect(find.byType(CupertinoLayout), findsOneWidget);
      });
    });

    testWidgets(
        'Should display FluentLayout with for '
        'desktop platform and fluent state', (final tester) async {
      await tester.runAsync(() async {
        final platform = GetIt.I.get<Platform>();
        final desktopService = GetIt.I.get<DesktopService>();

        when(platform.isIos).thenReturn(false);
        when(platform.isAndroid).thenReturn(false);
        when(platform.isDesktop).thenReturn(true);
        when(desktopService.state).thenReturn('fluent');

        await tester.pumpWidget(const App(child: SizedBox()));

        await tester.pump();

        expect(find.byType(FluentLayout), findsOneWidget);
      });
    });

    testWidgets(
        'Should display DesktopSelectorPage for '
        'Desktop platform with state none', (final tester) async {
      await tester.runAsync(() async {
        final platform = GetIt.I.get<Platform>();
        final desktopService = GetIt.I.get<DesktopService>();

        when(platform.isIos).thenReturn(false);
        when(platform.isAndroid).thenReturn(false);
        when(platform.isDesktop).thenReturn(true);
        when(desktopService.state).thenReturn('none');

        await tester.pumpWidget(const App(child: SizedBox()));

        await tester.pump();

        expect(find.byType(DesktopSelectorPage), findsOneWidget);
      });
    });
  });
}
