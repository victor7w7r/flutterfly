import 'package:fl_query/fl_query.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/features/common/business/entities/bitcoin.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import '../../../../../setup.dart';

class MockFluentService extends Mock
    with ChangeNotifier
    implements FluentService {}

class MockBinanceService extends Mock implements BinanceService {}

class MockQuery extends Mock implements Query<List<Bitcoin>, FetchException> {}

void main() {
  group('HomeWidgets', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = MockPathProviderPlatform();
      await QueryClient.initialize(cachePrefix: 'secondable');
      registerFallbackValue(MockQuery());
    });

    setUp(() async {
      await GetIt.I.reset();
      GetIt.I.registerSingleton<FluentService>(MockFluentService());
      when(GetIt.I<FluentService>().state).thenReturn(FluentThemeApp.dark());
    });

    group('ColorButton', () {
      testWidgets('Renders widget successfully and do onClick',
          (final tester) async {
        await tester.runAsync(() async {
          var isClicked = false;

          await tester.pumpWidget(
            FluentApp(
              home: ColorButton(
                back: Colors.black,
                border: Colors.white,
                onClick: () {
                  isClicked = true;
                },
              ),
            ),
          );

          final button = find.byType(ColorButton);
          expect(button, findsOneWidget);

          await tester.pump();
          await tester.tap(button);

          expect(isClicked, true);
        });
      });
    });

    group('HomeCardBrand', () {
      testWidgets('Renders widget successfully with no state',
          (final tester) async {
        await tester.pumpWidget(const FluentApp(home: HomeCardBrand()));

        expect(find.byType(HomeCardBrand), findsOneWidget);
        expect(find.byType(Card), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
        expect(find.text('Made with love by'), findsOneWidget);
        expect(find.byType(Image), findsOneWidget);
        expect(find.text('Happy Hacking!, Dart... Dart...'), findsOneWidget);
        expect(find.text('This UI is powered by'), findsOneWidget);
        expect(find.text('Fluent UI'), findsOneWidget);
      });
    });

    group('HomeCardCrypto', () {
      testWidgets('Renders widget successfully with data and not state',
          (final tester) async {
        GetIt.I.registerSingleton<DataService>(DataService());
        GetIt.I.registerSingleton<BinanceService>(MockBinanceService());
        final srv = GetIt.I<BinanceService>();
        when(srv.getBitcoin).thenAnswer((final _) async => Bitcoin.dummy());

        await tester.runAsync(() async {
          await tester.pumpWidget(
            QueryClientProvider(
              child: const FluentApp(home: HomeCardCrypto()),
            ),
          );

          expect(find.byType(ProgressRing), findsOneWidget);

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await tester.pump();

          expect(find.text('Store state: Not yet.'), findsOneWidget);

          expect(find.byType(Column), findsNWidgets(2));
          expect(find.text('Symbol: DUMMY'), findsOneWidget);
          expect(find.text('Price: 0.00'), findsOneWidget);
        });
      });

      testWidgets('Renders widget successfully with query error and state',
          (final tester) async {
        GetIt.I.registerSingleton<DataService>(DataService());
        GetIt.I.registerSingleton<BinanceService>(MockBinanceService());
        final srv = GetIt.I<BinanceService>();
        when(srv.getBitcoin).thenAnswer((final _) async => Bitcoin.dummy());

        GetIt.I<DataService>().mutate = 'test';

        await tester.runAsync(() async {
          await tester.pumpWidget(
            QueryClientProvider(
              child: const FluentApp(home: HomeCardCrypto(mockError: true)),
            ),
          );

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await tester.pump();

          expect(find.text('An error occurred'), findsOneWidget);
        });
      });
    });
  });
}
