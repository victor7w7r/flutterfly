import 'package:flutter/material.dart';

import 'package:fl_query/fl_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';
import 'package:flutterfly/features/common/ui/services/data_service.dart';
import 'package:flutterfly/features/material/ui/pages/home/home_widgets.dart';
import 'package:flutterfly/features/material/ui/services/material_service.dart';
import '../../../../../setup.dart';

class MockMaterialService extends Mock
    with ChangeNotifier
    implements MaterialService {}

class MockPlatform extends Mock implements Platform {}

class MockBinanceService extends Mock implements BinanceService {}

class MockQuery extends Mock implements Query<List<Binance>, FetchException> {}

void main() {
  group('HomeWidgets', () {
    group('TopContent', () {
      setUp(() async {
        await GetIt.I.reset();
        GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
        GetIt.I.registerSingleton<DataService>(DataService());
      });
      testWidgets('Render widget successfully with portrait and state',
          (final tester) async {
        final service = GetIt.I<MaterialService>();
        final ctl = GetIt.I<DataService>();
        when(service.isDark).thenReturn(false);
        ctl.mutate = 'Hello, Flutter!';

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TopContent(
                height: 1000,
                pOrientation: Orientation.portrait,
              ),
            ),
          ),
        );

        expect(find.text('Happy Hacking!, Dart... Dart...'), findsOneWidget);
        expect(find.byType(Row), findsNWidgets(2));
        expect(find.text('Made with love by '), findsOneWidget);
      });

      testWidgets('Render widget successfully with landscape and empty state',
          (final tester) async {
        final service = GetIt.I<MaterialService>();
        when(service.isDark).thenReturn(false);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: TopContent(
                height: 1000,
                pOrientation: Orientation.landscape,
              ),
            ),
          ),
        );

        expect(find.text('Happy Hacking!, Dart... Dart...'), findsOneWidget);
        expect(find.text('Store state: Not yet.'), findsOneWidget);
        expect(find.byType(Row), findsNWidgets(2));
        expect(find.text('Made with love by '), findsOneWidget);
      });

      testWidgets(
          'Render widget successfully set '
          'home in false and dark mode in true', (final tester) async {
        final service = GetIt.I<MaterialService>();
        when(service.isDark).thenReturn(true);

        tester.view.physicalSize = const Size(1600, 900);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: DynamicChip(isHome: true),
            ),
          ),
        );

        expect(find.byType(Container), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
      });
    });

    group('DynamicChip', () {
      setUp(() async {
        await GetIt.I.reset();
        GetIt.I.registerSingleton<MaterialService>(MockMaterialService());
        GetIt.I.registerSingleton<Platform>(Platform());
      });
      testWidgets(
          'Render widget successfully set '
          'home in true and dark mode in false', (final tester) async {
        final service = GetIt.I<MaterialService>();
        when(service.isDark).thenReturn(false);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: DynamicChip(isHome: true),
            ),
          ),
        );

        expect(find.byType(Container), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
      });

      testWidgets(
          'Render widget successfully set '
          'home in false and dark mode in true', (final tester) async {
        final service = GetIt.I<MaterialService>();
        when(service.isDark).thenReturn(true);

        tester.view.physicalSize = const Size(1600, 900);

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: DynamicChip(isHome: true),
            ),
          ),
        );

        expect(find.byType(Container), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
      });
    });

    group('BottomContent', () {
      Widget widget(final Orientation or, {final bool mockError = false}) =>
          QueryClientProvider(
            child: MaterialApp(
              home: Scaffold(
                body: BottomContent(
                  pOrientation: or,
                  height: 1000,
                  mockError: mockError,
                ),
              ),
            ),
          );

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
        final service = GetIt.I<MaterialService>();
        when(service.isDark).thenReturn(false);
      });

      testWidgets('Render widget successfully when data is ready',
          (final tester) async {
        final srv = GetIt.I<BinanceService>();

        when(srv.fetchBinance)
            .thenAnswer((final _) async => Binance.dummyGen());

        await tester.runAsync(() async {
          await tester.pumpWidget(widget(Orientation.portrait));

          expect(find.byType(CircularProgressIndicator), findsOneWidget);

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await tester.pump();

          expect(find.byType(GridView), findsOneWidget);
          expect(find.byType(CurrencyCard), findsWidgets);
        });
      });

      testWidgets('Renders an error in widget query', (final tester) async {
        final srv = GetIt.I<BinanceService>();

        when(srv.fetchBinance)
            .thenAnswer((final _) async => Binance.dummyGen());

        await tester.runAsync(() async {
          await tester
              .pumpWidget(widget(Orientation.portrait, mockError: true));

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await tester.pump();

          expect(find.text('An error occurred'), findsOneWidget);
        });
      });

      testWidgets(
          'ScrollListener invokes paginateBinance when scrolled to bottom',
          (final tester) async {
        final srv = GetIt.I<BinanceService>();

        when(srv.fetchBinance)
            .thenAnswer((final _) async => Binance.dummyGen());
        when(() => srv.paginateBinance(any())).thenAnswer((final _) {});

        await tester.runAsync(() async {
          await tester.pumpWidget(widget(Orientation.portrait));

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await tester.pump();

          final state =
              tester.state<BottomContentState>(find.byType(BottomContent));
          final scrCtl = state.scrCtl;
          scrCtl.jumpTo(scrCtl.position.maxScrollExtent);

          verify(() => srv.paginateBinance(any())).called(1);
        });
      });

      testWidgets('OnRefresh is called when pulling to refresh',
          (final tester) async {
        final srv = GetIt.I<BinanceService>();

        when(srv.fetchBinance)
            .thenAnswer((final _) async => Binance.dummyGen());
        when(() => srv.refreshBinance(any())).thenAnswer((final _) {});

        await tester.runAsync(() async {
          await tester.pumpWidget(widget(Orientation.portrait));

          await Future<void>.delayed(const Duration(milliseconds: 150));
          await tester.pump();

          final gridView = find.byType(GridView);
          await tester.drag(gridView, const Offset(0.0, 300.0));

          await tester.pumpAndSettle();

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

        GetIt.I.registerLazySingleton<MaterialService>(MockMaterialService.new);
        final service = GetIt.I<MaterialService>();
        when(service.isDark).thenReturn(false);
      });
      testWidgets(
          'Render widget successfully with landscape/dark, portait/light',
          (final tester) async {
        when(GetIt.I<MaterialService>().isDark).thenReturn(true);
        await tester.pumpWidget(widget(Orientation.landscape));

        expect(find.byType(Container), findsWidgets);
        expect(find.byType(Column), findsWidgets);
        expect(find.text('BTC'), findsOneWidget);
        expect(find.text('1.0%'), findsOneWidget);
        expect(find.text('1.0'), findsOneWidget);

        when(GetIt.I<MaterialService>().isDark).thenReturn(false);

        await tester.pumpWidget(widget(Orientation.portrait));

        expect(find.byType(Container), findsWidgets);
        expect(find.byType(Column), findsWidgets);
        expect(find.text('BTC'), findsOneWidget);
        expect(find.text('1.0%'), findsOneWidget);
        expect(find.text('1.0'), findsOneWidget);
      });

      testWidgets('Render SizedBox in various context size',
          (final tester) async {
        tester.view.physicalSize = const Size(620, 800);

        await tester.pumpWidget(widget(Orientation.portrait));
        expect(find.byType(Column), findsOneWidget);

        tester.view.physicalSize = const Size(480, 800);
        await tester.pumpWidget(widget(Orientation.portrait));

        expect(find.byType(Column), findsOneWidget);

        tester.view.physicalSize = const Size(220, 800);

        await tester.pumpWidget(widget(Orientation.portrait));
        expect(find.byType(Column), findsOneWidget);
      });
    });
  });
}
