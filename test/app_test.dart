import 'package:flutter/widgets.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart' show Mock, when;
import 'package:patrol/patrol.dart' show patrolWidgetTest;

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

final class MockPlatform extends Mock implements Platform {}

final class MockDesktopService extends Mock implements DesktopService {}

final class MockCupertinoService extends Mock implements CupertinoService {}

final class MockMaterialService extends Mock implements MaterialService {}

final class MockFluentService extends Mock implements FluentService {}

final class MockDesktopSelectorController extends Mock
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

      when(() => GetIt.I<CupertinoService>().isDark).thenReturn(false);
      when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);
      when(() => GetIt.I<FluentService>().state).thenReturn(
        FluentThemeApp.dark(),
      );
      when(() => GetIt.I<DesktopSelectorController>().isInitAnim)
          .thenReturn(false);
    });
    patrolWidgetTest('should display CupertinoLayout for iOS platform',
        (final $) async {
      final platform = GetIt.I<Platform>();

      when(() => platform.isIos).thenReturn(true);
      when(() => platform.isAndroid).thenReturn(false);
      when(() => platform.isDesktop).thenReturn(false);
      when(() => platform.isMacOS).thenReturn(false);
      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const App(child: SizedBox()));
        expect($(CupertinoLayout), findsOneWidget);
      });
    });
    patrolWidgetTest('should display MaterialLayout for Android platform',
        (final $) async {
      final platform = GetIt.I<Platform>();

      when(() => platform.isIos).thenReturn(false);
      when(() => platform.isAndroid).thenReturn(true);
      when(() => platform.isDesktop).thenReturn(false);
      when(() => platform.isMacOS).thenReturn(false);

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const App(child: SizedBox()));
        expect($(MaterialLayout), findsOneWidget);
      });
    });

    patrolWidgetTest(
        'should display MaterialLayout with for '
        'desktop platform and material state', (final $) async {
      final platform = GetIt.I<Platform>();
      final desktopService = GetIt.I<DesktopService>();

      when(() => platform.isIos).thenReturn(false);
      when(() => platform.isAndroid).thenReturn(false);
      when(() => platform.isDesktop).thenReturn(true);
      when(() => desktopService.state).thenReturn('material');
      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const App(child: SizedBox()));
        expect($(MaterialLayout), findsOneWidget);
      });
    });

    patrolWidgetTest(
        'should display CupertinoLayout with for '
        'desktop platform and cupertino state', (final $) async {
      final platform = GetIt.I<Platform>();
      final desktopService = GetIt.I<DesktopService>();

      when(() => platform.isIos).thenReturn(false);
      when(() => platform.isAndroid).thenReturn(false);
      when(() => platform.isDesktop).thenReturn(true);
      when(() => platform.isMacOS).thenReturn(false);
      when(() => desktopService.state).thenReturn('cupertino');

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const App(child: SizedBox()));
        expect($(CupertinoLayout), findsOneWidget);
      });
    });

    patrolWidgetTest(
        'should display FluentLayout with for '
        'desktop platform and fluent state', (final $) async {
      final platform = GetIt.I<Platform>();
      final desktopService = GetIt.I<DesktopService>();

      when(() => platform.isIos).thenReturn(false);
      when(() => platform.isAndroid).thenReturn(false);
      when(() => platform.isDesktop).thenReturn(true);
      when(() => desktopService.state).thenReturn('fluent');

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const App(child: SizedBox()));
        expect($(FluentLayout), findsOneWidget);
      });
    });

    patrolWidgetTest(
        'should display DesktopSelectorPage for '
        'Desktop platform with state none', (final $) async {
      final platform = GetIt.I<Platform>();
      final desktopService = GetIt.I<DesktopService>();

      when(() => platform.isIos).thenReturn(false);
      when(() => platform.isAndroid).thenReturn(false);
      when(() => platform.isDesktop).thenReturn(true);
      when(() => desktopService.state).thenReturn('none');

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(const App(child: SizedBox()));
        expect($(DesktopSelectorPage), findsOneWidget);
      });
    });
  });
}
