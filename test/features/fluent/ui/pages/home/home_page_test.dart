import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/fluent/ui/widgets/widgets.dart';

final class MockFluentService extends Mock
    with ChangeNotifier
    implements FluentService {}

final class MockPlatform extends Mock implements Platform {}

void main() {
  group('HomeWidgets', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<FluentService>(MockFluentService());
      GetIt.I.registerSingleton<Platform>(MockPlatform());

      registerFallbackValue(<Colors>[]);

      final srv = GetIt.I<FluentService>();
      when(() => srv.state).thenReturn(FluentThemeApp.dark());
      when(() => srv.interpolator(any())).thenReturn(null);
      when(() => GetIt.I<Platform>().isWeb).thenReturn(false);
    });

    patrolWidgetTest('renders page successfully', (final $) async {
      await $.pumpWidgetAndSettle(
        const FluentApp(
          home: HomePage(
            child: HomePage(secondMockChild: SizedBox()),
          ),
        ),
      );

      expect($(Header), findsOneWidget);
      expect($(Column), findsNWidgets(3));
      expect($(HomeCardCrypto), findsOneWidget);
      expect($(HomeCardBrand), findsOneWidget);
      expect($(BlurButton), findsOneWidget);
      expect($(ColorButton), findsNWidgets(4));
    });

    patrolWidgetTest('renders page successfully with other width and height',
        (final $) async {
      $.tester.view.physicalSize = const Size(2950, 1800);

      await $.pumpWidgetAndSettle(
        const FluentApp(home: HomePage(secondMockChild: SizedBox())),
      );

      expect($(Header), findsOneWidget);
      expect($(Column), findsNWidgets(2));

      $.tester.view.physicalSize = const Size(2400, 1800);
    });

    patrolWidgetTest('click buttons and navigation', (final $) async {
      await $.pumpWidgetAndSettle(
        FluentApp(
          home: const HomePage(
            child: HomePage(secondMockChild: SizedBox()),
          ),
          routes: {
            '/store': (final _) => const Placeholder(),
          },
        ),
      );

      final colorButtonFinder = $(ColorButton);
      expect(colorButtonFinder, findsNWidgets(4));

      await $(colorButtonFinder.at(0)).tap();
      await $.pumpAndSettle();

      await $(colorButtonFinder.at(1)).tap();
      await $.pumpAndSettle();

      await $(colorButtonFinder.at(2)).tap();
      await $.pumpAndSettle();

      await $(colorButtonFinder.at(3)).tap();
      await $.pumpAndSettle();

      verify(() => GetIt.I<FluentService>().interpolator(any())).called(4);

      final blurButtonFinder = $(BlurButton);
      expect(blurButtonFinder, findsOneWidget);

      await $(blurButtonFinder).tap();
      await $.pumpAndSettle();

      expect($(Placeholder), findsOneWidget);
    });
  });
}
