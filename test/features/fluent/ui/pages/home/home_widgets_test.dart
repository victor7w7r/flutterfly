import 'package:fl_query/fl_query.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/features/common/business/entities/bitcoin.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/fluent/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/fluent/ui/services/fluent_service.dart';
import '../../../../../setup.dart';

final class MockFluentService extends Mock
    with ChangeNotifier
    implements FluentService {}

final class MockBinanceService extends Mock implements BinanceService {}

final class MockQuery extends Mock
    implements Query<List<Bitcoin>, FetchException> {}

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
      when(() => GetIt.I<FluentService>().state).thenReturn(
        FluentThemeApp.dark(),
      );
    });

    group('ColorButton', () {
      patrolWidgetTest(
        'renders widget successfully and do onClick',
        (final $) async => $.tester.runAsync(() async {
          var isClicked = false;

          await $.pumpWidgetAndSettle(
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

          expect($(ColorButton), findsOneWidget);

          await $.pump();
          await $(ColorButton).tap();

          expect(isClicked, true);
        }),
      );
    });

    group('HomeCardBrand', () {
      patrolWidgetTest('renders widget successfully with no state',
          (final $) async {
        await $.pumpWidgetAndSettle(const FluentApp(home: HomeCardBrand()));

        expect($(HomeCardBrand), findsOneWidget);
        expect($(Card), findsOneWidget);
        expect($(Column), findsOneWidget);
        expect($('Made with love by'), findsOneWidget);
        expect($(Image), findsOneWidget);
        expect($('Happy Hacking!, Dart... Dart...'), findsOneWidget);
        expect($('This UI is powered by'), findsOneWidget);
        expect($('Fluent UI'), findsOneWidget);
      });
    });

    group('HomeCardCrypto', () {
      setUp(() {
        GetIt.I.registerSingleton(DataService());
        GetIt.I.registerSingleton<BinanceService>(MockBinanceService());
        when(GetIt.I<BinanceService>().getBitcoin).thenAnswer(
          (final _) async => Bitcoin.dummy(),
        );
      });
      patrolWidgetTest(
        'renders widget successfully with data and not state',
        (final $) async => $.tester.runAsync(() async {
          await $.pumpWidgetAndSettle(
            QueryClientProvider(
              child: const FluentApp(home: HomeCardCrypto()),
            ),
          );

          expect($(ProgressRing), findsOneWidget);

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await $.pump();

          expect($('Store state: Not yet.'), findsOneWidget);

          expect($(Column), findsNWidgets(2));
          expect($('Symbol: DUMMY'), findsOneWidget);
          expect($('Price: 0.00'), findsOneWidget);
        }),
      );

      patrolWidgetTest('renders widget successfully with query error and state',
          (final $) async {
        GetIt.I<DataService>().mutate = 'test';

        await $.tester.runAsync(() async {
          await $.pumpWidgetAndSettle(
            QueryClientProvider(
              child: const FluentApp(home: HomeCardCrypto(mockError: true)),
            ),
          );

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await $.pump();

          expect($('An error occurred'), findsOneWidget);
        });
      });
    });
  });
}
