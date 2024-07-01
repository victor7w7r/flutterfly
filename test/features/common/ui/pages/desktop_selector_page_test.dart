import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watch_it/watch_it.dart' show GetIt;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_controller.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_page.dart';
import 'package:flutterfly/features/common/ui/pages/desktop_selector_widgets.dart';

class MockDesktopSelectorController extends Mock
    with ChangeNotifier
    implements DesktopSelectorController {}

class MockPlatform extends Mock implements Platform {}

void main() {
  group('DesktopSelectorPage', () {
    group('SelectionWrap', () {
      testWidgets(
          'renders three MenuBuilder widgets and handles taps correctly',
          (final tester) async {
        final controller = MockDesktopSelectorController();
        await tester.pumpWidget(MaterialApp(home: SelectionWrap(controller)));

        final menuBuilderFinder = find.byType(MenuBuilder);
        expect(menuBuilderFinder, findsNWidgets(3));

        final materialFinder = find.widgetWithText(MenuBuilder, 'Material');
        expect(materialFinder, findsOneWidget);
        await tester.tap(materialFinder);

        verify(() => controller.exit('material')).called(1);

        final fluentFinder = find.widgetWithText(MenuBuilder, 'Fluent');
        expect(fluentFinder, findsOneWidget);
        await tester.tap(fluentFinder);

        verify(() => controller.exit('web')).called(1);

        final cupertinoFinder = find.widgetWithText(MenuBuilder, 'Cupertino');
        expect(cupertinoFinder, findsOneWidget);
        await tester.tap(cupertinoFinder);

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
      testWidgets('initializes correctly and responds to isInitAnim',
          (final tester) async {
        await tester.runAsync(() async {
          final controller = GetIt.I.get<DesktopSelectorController>();
          final platform = GetIt.I.get<Platform>();

          when(platform.isDesktop).thenReturn(true);
          when(() => controller.isInitAnim).thenReturn(false);

          await tester.pumpWidget(
            const MaterialApp(home: DesktopSelectorPage(child: SizedBox())),
          );

          when(() => controller.isInitAnim).thenReturn(true);

          verify(controller.init).called(1);

          tester.view.physicalSize = const Size(400, 800);

          await tester.pump();

          expect(find.byType(SingleChildScrollView), findsOneWidget);
        });
      });
    });
  });
}
