import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;
import 'package:watch_it/watch_it.dart' show GetIt;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_controller.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_page.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_widgets.dart';

final class MockDesktopSelectorController extends Mock
    with ChangeNotifier
    implements DesktopSelectorController {}

final class MockPlatform extends Mock implements Platform {}

void main() {
  group('DesktopSelectorPage', () {
    group('SelectionWrap', () {
      patrolWidgetTest(
          'renders three MenuBuilder widgets and handles taps correctly',
          (final $) async {
        final controller = MockDesktopSelectorController();
        await $.pumpWidgetAndSettle(
          MaterialApp(home: SelectionWrap(controller)),
        );

        expect($(MenuBuilder), findsNWidgets(3));

        final materialFinder = find.widgetWithText(MenuBuilder, 'Material');
        expect(materialFinder, findsOneWidget);
        await $.tester.tap(materialFinder);

        verify(() => controller.exit('material')).called(1);

        final fluentFinder = find.widgetWithText(MenuBuilder, 'Fluent');
        expect(fluentFinder, findsOneWidget);
        await $.tap(fluentFinder);

        verify(() => controller.exit('web')).called(1);

        final cupertinoFinder = find.widgetWithText(MenuBuilder, 'Cupertino');
        expect(cupertinoFinder, findsOneWidget);
        await $.tap(cupertinoFinder);

        verify(() => controller.exit('cupertino')).called(1);
      });
    });

    group('DesktopSelectorPage', () {
      setUp(() {
        GetIt.I.registerLazySingleton<DesktopSelectorController>(
          MockDesktopSelectorController.new,
        );
        GetIt.I.registerSingleton<Platform>(MockPlatform());
      });
      patrolWidgetTest('initializes correctly and responds to isInitAnim',
          (final $) async {
        final controller = GetIt.I<DesktopSelectorController>();
        final platform = GetIt.I<Platform>();

        when(() => platform.isDesktop).thenReturn(true);
        when(() => controller.isInitAnim).thenReturn(false);

        await $.tester.runAsync(() async {
          await $.pumpWidgetAndSettle(
            const MaterialApp(home: DesktopSelectorPage(child: SizedBox())),
          );

          when(() => controller.isInitAnim).thenReturn(true);

          verify(controller.init).called(1);

          $.tester.view.physicalSize = const Size(400, 800);

          await $.pump();

          expect($(SingleChildScrollView), findsOneWidget);
        });
      });
    });
  });
}
