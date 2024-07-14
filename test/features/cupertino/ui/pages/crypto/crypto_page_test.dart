import 'package:flutter/cupertino.dart';

import 'package:fl_query/fl_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:patrol/patrol.dart' show patrolWidgetTest;

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

      when(() => service.isDark).thenReturn(false);
    });
    patrolWidgetTest('render widget successfully when data is ready',
        (final $) async {
      final srv = GetIt.I<BinanceService>();

      when(srv.fetchBinance).thenAnswer((final _) async => Binance.dummyGen());

      await $.tester.runAsync(() async {
        await $.pumpWidget(page);

        expect($(CupertinoActivityIndicator), findsOneWidget);

        await Future<void>.delayed(const Duration(milliseconds: 150));
        await $.pump();

        expect($(CustomScrollView), findsOneWidget);
        expect($(CurrencyCard), findsWidgets);
      });
    });

    patrolWidgetTest('renders an error in widget query', (final $) async {
      when(GetIt.I<BinanceService>().fetchBinance)
          .thenAnswer((final _) async => Binance.dummyGen());

      await $.tester.runAsync(() async {
        await $.tester.pumpWidget(
          QueryClientProvider(
            child: const CupertinoApp(
              home: CupertinoPageScaffold(child: CryptoPage(mockError: true)),
            ),
          ),
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

      when(srv.fetchBinance).thenAnswer((final _) async => Binance.dummyGen());
      when(() => srv.paginateBinance(any())).thenAnswer((final _) {});

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(page);

        await Future<void>.delayed(const Duration(milliseconds: 150));
        await $.pump();

        final state = $.tester.state<CryptoPageState>($(CryptoPage));
        final scrCtl = state.scrCtl;
        scrCtl.jumpTo(scrCtl.position.maxScrollExtent);

        verify(() => srv.paginateBinance(any())).called(1);
      });
    });

    patrolWidgetTest('OnRefresh is called when pulling to refresh',
        (final $) async {
      final srv = GetIt.I<BinanceService>();

      when(srv.fetchBinance).thenAnswer((final _) async => Binance.dummyGen());
      when(() => srv.refreshBinance(any())).thenAnswer((final _) {});

      await $.tester.runAsync(() async {
        await $.pumpWidgetAndSettle(page);

        await Future<void>.delayed(const Duration(milliseconds: 150));
        await $.pump();

        final customScrollView = $(CustomScrollView);
        await $.tester.drag(customScrollView, const Offset(0.0, 300.0));

        await $.pumpAndSettle();

        verify(() => srv.refreshBinance(any())).called(1);
      });
    });
  });
}
