import 'package:flutter/cupertino.dart';

import 'package:fl_query/fl_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';
import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto_page.dart';
import 'package:flutterfly/features/cupertino/ui/pages/crypto/crypto_widgets.dart';
import 'package:flutterfly/features/cupertino/ui/services/cupertino_service.dart';
import '../../../../../setup.dart';

final class MockCupertinoService extends Mock
    with ChangeNotifier
    implements CupertinoService {}

final class MockBinanceService extends Mock implements BinanceService {}

final class MockQuery extends Mock
    implements Query<List<Binance>, FetchException> {}

void main() {
  group('CryptoPage', () {
    final page = QueryClientProvider(
      child: const CupertinoApp(
        home: CupertinoPageScaffold(
          child: CryptoPage(),
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
      GetIt.I.registerSingleton<CupertinoService>(MockCupertinoService());
      GetIt.I.registerSingleton<BinanceService>(MockBinanceService());
      final service = GetIt.I<CupertinoService>();
      when(service.isDark).thenReturn(false);
    });
    testWidgets('Render widget successfully when data is ready',
        (final tester) async {
      final srv = GetIt.I<BinanceService>();

      when(srv.fetchBinance).thenAnswer((final _) async => Binance.dummyGen());

      await tester.runAsync(() async {
        await tester.pumpWidget(page);

        expect(find.byType(CupertinoActivityIndicator), findsOneWidget);

        await Future<void>.delayed(const Duration(milliseconds: 150));
        await tester.pump();

        expect(find.byType(CustomScrollView), findsOneWidget);
        expect(find.byType(CurrencyCard), findsWidgets);
      });
    });

    testWidgets('Renders an error in widget query', (final tester) async {
      final srv = GetIt.I<BinanceService>();

      when(srv.fetchBinance).thenAnswer((final _) async => Binance.dummyGen());

      await tester.runAsync(() async {
        await tester.pumpWidget(
          QueryClientProvider(
            child: const CupertinoApp(
              home: CupertinoPageScaffold(child: CryptoPage(mockError: true)),
            ),
          ),
        );

        await Future<void>.delayed(const Duration(milliseconds: 150));
        await tester.pump();

        expect(find.text('An error occurred'), findsOneWidget);
      });
    });

    testWidgets(
        'ScrollListener invokes paginateBinance when scrolled to bottom',
        (final tester) async {
      final srv = GetIt.I<BinanceService>();

      when(srv.fetchBinance).thenAnswer((final _) async => Binance.dummyGen());
      when(() => srv.paginateBinance(any())).thenAnswer((final _) {});

      await tester.runAsync(() async {
        await tester.pumpWidget(page);

        await Future<void>.delayed(const Duration(milliseconds: 150));
        await tester.pump();

        final state = tester.state<CryptoPageState>(find.byType(CryptoPage));
        final scrCtl = state.scrCtl;
        scrCtl.jumpTo(scrCtl.position.maxScrollExtent);

        verify(() => srv.paginateBinance(any())).called(1);
      });
    });

    testWidgets('OnRefresh is called when pulling to refresh',
        (final tester) async {
      final srv = GetIt.I<BinanceService>();

      when(srv.fetchBinance).thenAnswer((final _) async => Binance.dummyGen());
      when(() => srv.refreshBinance(any())).thenAnswer((final _) {});

      await tester.runAsync(() async {
        await tester.pumpWidget(page);

        await Future<void>.delayed(const Duration(milliseconds: 150));
        await tester.pump();

        final customScrollView = find.byType(CustomScrollView);
        await tester.drag(customScrollView, const Offset(0.0, 300.0));

        await tester.pumpAndSettle();

        verify(() => srv.refreshBinance(any())).called(1);
      });
    });
  });
}
