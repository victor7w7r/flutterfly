import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_page.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import 'package:flutterfly/features/fluent/ui/widgets/widgets.dart';

class MockFluentService extends Mock
    with ChangeNotifier
    implements FluentService {}

class MockPlatform extends Mock implements Platform {}

void main() {
  group('HomeWidgets', () {
    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<FluentService>(MockFluentService());
      GetIt.I.registerSingleton<Platform>(MockPlatform());

      registerFallbackValue(<Colors>[]);

      final srv = GetIt.I<FluentService>();
      when(srv.state).thenReturn(FluentThemeApp.dark());
      when(() => srv.interpolator(any())).thenReturn(null);
      when(GetIt.I<Platform>().isWeb).thenReturn(false);
    });

    testWidgets('Renders page successfully', (final tester) async {
      await tester.pumpWidget(
        const FluentApp(
          home: HomePage(
            child: HomePage(secondMockChild: SizedBox()),
          ),
        ),
      );

      expect(find.byType(Header), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(3));
      expect(find.byType(HomeCardCrypto), findsOneWidget);
      expect(find.byType(HomeCardBrand), findsOneWidget);
      expect(find.byType(BlurButton), findsOneWidget);
      expect(find.byType(ColorButton), findsNWidgets(4));
    });

    testWidgets('Renders page successfully with other width and height',
        (final tester) async {
      tester.view.physicalSize = const Size(2950, 1800);

      await tester.pumpWidget(
        const FluentApp(home: HomePage(secondMockChild: SizedBox())),
      );

      expect(find.byType(Header), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(2));

      tester.view.physicalSize = const Size(2400, 1800);
    });

    testWidgets('Click buttons and navigation', (final tester) async {
      await tester.pumpWidget(
        FluentApp(
          home: const HomePage(
            child: HomePage(secondMockChild: SizedBox()),
          ),
          routes: {
            '/store': (final _) => const Placeholder(),
          },
        ),
      );

      final colorButtonFinder = find.byType(ColorButton);
      expect(colorButtonFinder, findsNWidgets(4));

      await tester.tap(colorButtonFinder.at(0));
      await tester.pumpAndSettle();

      await tester.tap(colorButtonFinder.at(1));
      await tester.pumpAndSettle();

      await tester.tap(colorButtonFinder.at(2));
      await tester.pumpAndSettle();

      await tester.tap(colorButtonFinder.at(3));
      await tester.pumpAndSettle();

      verify(() => GetIt.I<FluentService>().interpolator(any())).called(4);

      final blurButtonFinder = find.byType(BlurButton);
      expect(blurButtonFinder, findsOneWidget);

      await tester.tap(blurButtonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(Placeholder), findsOneWidget);
    });
  });
}
