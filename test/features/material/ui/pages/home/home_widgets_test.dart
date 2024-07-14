import 'package:flutter/material.dart';

import 'package:fl_query/fl_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';
import '../../../../../setup.dart';

final class MockMaterialService extends Mock
    with ChangeNotifier
    implements MaterialService {}

final class MockPlatform extends Mock implements Platform {}

final class MockBinanceService extends Mock implements BinanceService {}

final class MockQuery extends Mock
    implements Query<List<Binance>, FetchException> {}

void main() {
  group('HomeWidgets', () {
    group('TopContent', () {
      setUp(() async {
        await GetIt.I.reset();
        GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
        GetIt.I.registerSingleton<DataService>(DataService());
      });
      patrolWidgetTest('render widget successfully with portrait and state',
          (final $) async {
        when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);
        GetIt.I<DataService>().mutate = 'Hello, Flutter!';

        await $.pumpWidgetAndSettle(
          const MaterialApp(
            home: Scaffold(
              body: TopContent(
                height: 1000,
                pOrientation: Orientation.portrait,
              ),
            ),
          ),
        );

        expect($('Happy Hacking!, Dart... Dart...'), findsOneWidget);
        expect($(Row), findsNWidgets(2));
        expect($('Made with love by '), findsOneWidget);
      });

      patrolWidgetTest(
          'Render widget successfully with landscape and empty state',
          (final $) async {
        when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

        await $.pumpWidgetAndSettle(
          const MaterialApp(
            home: Scaffold(
              body: TopContent(
                height: 1000,
                pOrientation: Orientation.landscape,
              ),
            ),
          ),
        );

        expect($('Happy Hacking!, Dart... Dart...'), findsOneWidget);
        expect($('Store state: Not yet.'), findsOneWidget);
        expect($(Row), findsNWidgets(2));
        expect($('Made with love by '), findsOneWidget);
      });

      patrolWidgetTest(
          'Render widget successfully set '
          'home in false and dark mode in true', (final $) async {
        when(() => GetIt.I<MaterialService>().isDark).thenReturn(true);

        $.tester.view.physicalSize = const Size(1600, 900);

        await $.pumpWidgetAndSettle(
          const MaterialApp(
            home: Scaffold(body: DynamicChip(isHome: true)),
          ),
        );

        expect($(Container), findsOneWidget);
        expect($(Row), findsOneWidget);
      });
    });

    group('DynamicChip', () {
      setUp(() async {
        await GetIt.I.reset();

        GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
        GetIt.I.registerSingleton(Platform());
      });
      patrolWidgetTest(
          'Render widget successfully set '
          'home in true and dark mode in false', (final $) async {
        when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

        await $.pumpWidgetAndSettle(
          const MaterialApp(
            home: Scaffold(
              body: DynamicChip(isHome: true),
            ),
          ),
        );

        expect($(Container), findsOneWidget);
        expect($(Row), findsOneWidget);
      });

      patrolWidgetTest(
          'Render widget successfully set '
          'home in false and dark mode in true', (final $) async {
        when(() => GetIt.I<MaterialService>().isDark).thenReturn(true);

        $.tester.view.physicalSize = const Size(1600, 900);

        await $.pumpWidgetAndSettle(
          const MaterialApp(
            home: Scaffold(
              body: DynamicChip(isHome: true),
            ),
          ),
        );

        expect($(Container), findsOneWidget);
        expect($(Row), findsOneWidget);
      });
    });

    group('BottomContent', () {
      setUpAll(() async {
        TestWidgetsFlutterBinding.ensureInitialized();
        PathProviderPlatform.instance = MockPathProviderPlatform();
        await QueryClient.initialize(cachePrefix: 'secondable');
        registerFallbackValue(MockQuery());
      });

      setUp(() async {
        await GetIt.I.reset();

        GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
        GetIt.I.registerSingleton<BinanceService>(MockBinanceService());
        when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);
      });

      Widget widget(final Orientation or, {final bool mockError = false}) =>
          QueryClientProvider(
            child: MaterialApp(
              home: Scaffold(
                body: BottomContent(
                  height: 1000,
                  pOrientation: or,
                  mockError: mockError,
                ),
              ),
            ),
          );

      patrolWidgetTest('render widget successfully when data is ready',
          (final $) async {
        when(GetIt.I<BinanceService>().fetchBinance)
            .thenAnswer((final _) async => Binance.dummyGen());

        await $.tester.runAsync(() async {
          await $.pumpWidget(widget(Orientation.portrait));

          expect($(CircularProgressIndicator), findsOneWidget);

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await $.pump();

          expect($(GridView), findsOneWidget);
          expect($(CurrencyCard), findsWidgets);
        });
      });

      patrolWidgetTest('renders an error in widget query', (final $) async {
        when(GetIt.I<BinanceService>().fetchBinance)
            .thenAnswer((final _) async => Binance.dummyGen());

        await $.tester.runAsync(() async {
          await $.pumpWidget(
            widget(Orientation.portrait, mockError: true),
          );

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await $.pump();

          expect($('An error occurred'), findsOneWidget);
        });
      });

      patrolWidgetTest(
          'ScrollListener invokes paginateBinance when scrolled to bottom',
          (final $) async {
        final srv = GetIt.I<BinanceService>();

        when(srv.fetchBinance)
            .thenAnswer((final _) async => Binance.dummyGen());
        when(() => srv.paginateBinance(any())).thenAnswer((final _) {});

        await $.tester.runAsync(() async {
          await $.pumpWidget(widget(Orientation.portrait));

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await $.pump();

          final state = $.tester.state<BottomContentState>($(BottomContent));
          final scrCtl = state.scrCtl;
          scrCtl.jumpTo(scrCtl.position.maxScrollExtent);

          verify(() => srv.paginateBinance(any())).called(1);
        });
      });

      patrolWidgetTest('OnRefresh is called when pulling to refresh',
          (final $) async {
        final srv = GetIt.I<BinanceService>();

        when(srv.fetchBinance)
            .thenAnswer((final _) async => Binance.dummyGen());
        when(() => srv.refreshBinance(any())).thenAnswer((final _) {});

        await $.tester.runAsync(() async {
          await $.pumpWidget(widget(Orientation.portrait));

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await $.pump();

          await $.tester.drag($(GridView), const Offset(0.0, 300.0));

          await $.pumpAndSettle();

          verify(() => srv.refreshBinance(any())).called(1);
        });
      });
    });

    group('CurrencyCard', () {
      Widget widget(final Orientation or) => MaterialApp(
            home: Scaffold(
              body: CurrencyCard(
                orientation: or,
                per: '1.0',
                pri: '1.0',
                sym: 'BTC',
              ),
            ),
          );

      setUp(() async {
        await GetIt.I.reset();

        GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
        when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);
      });
      patrolWidgetTest(
          'Render widget successfully with landscape/dark, portait/light',
          (final $) async {
        when(() => GetIt.I<MaterialService>().isDark).thenReturn(true);
        await $.pumpWidgetAndSettle(widget(Orientation.landscape));

        expect($(Container), findsWidgets);
        expect($(Column), findsWidgets);
        expect($('BTC'), findsOneWidget);
        expect($('1.0%'), findsOneWidget);
        expect($('1.0'), findsOneWidget);

        when(() => GetIt.I<MaterialService>().isDark).thenReturn(false);

        await $.pumpWidgetAndSettle(widget(Orientation.portrait));

        expect($(Container), findsWidgets);
        expect($(Column), findsWidgets);
        expect($('BTC'), findsOneWidget);
        expect($('1.0%'), findsOneWidget);
        expect($('1.0'), findsOneWidget);
      });

      patrolWidgetTest('render SizedBox in various context size',
          (final $) async {
        $.tester.view.physicalSize = const Size(620, 800);

        await $.pumpWidgetAndSettle(widget(Orientation.portrait));
        expect($(Column), findsOneWidget);

        $.tester.view.physicalSize = const Size(480, 800);
        await $.pumpWidgetAndSettle(widget(Orientation.portrait));

        expect($(Column), findsOneWidget);

        $.tester.view.physicalSize = const Size(220, 800);

        await $.pumpWidgetAndSettle(widget(Orientation.portrait));
        expect($(Column), findsOneWidget);
      });
    });
  });
}
