import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fl_query/fl_query.dart' show Query;
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' show Either;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/business/entities/entities.dart';
import 'package:flutterfly/features/common/business/usecases/usecases.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';

final class MockGetCurrenciesUseCase extends Mock
    implements GetCurrenciesUseCase {}

final class MockGetBitcoinUseCase extends Mock implements GetBitcoinUseCase {}

final class MockQuery extends Mock
    implements Query<List<Binance>, FetchException> {}

final class MockPlatform extends Mock implements Platform {}

void main() {
  group('BinanceService', () {
    late BinanceService binanceService;
    late MockGetCurrenciesUseCase mockGetCurrenciesUseCase;
    late MockGetBitcoinUseCase mockGetBitcoinUseCase;
    late MockPlatform mockPlatform;
    late MockQuery mockQuery;

    setUp(() async {
      await GetIt.I.reset();
      mockGetCurrenciesUseCase = MockGetCurrenciesUseCase();
      mockGetBitcoinUseCase = MockGetBitcoinUseCase();
      mockQuery = MockQuery();
      mockPlatform = MockPlatform();
      binanceService = BinanceService(
        mockGetCurrenciesUseCase,
        mockGetBitcoinUseCase,
        mockPlatform,
      );
      when(() => mockPlatform.isWeb).thenReturn(false);
    });

    test('call fetchBinance', () async {
      when(mockGetCurrenciesUseCase.call).thenAnswer(
        (final _) async => Either.right(Binance.dummyGen().lock),
      );

      await binanceService.fetchBinance();

      verify(mockGetCurrenciesUseCase.call).called(1);
    });

    test('call fetchBinance with web interface', () async {
      when(() => mockPlatform.isWeb).thenReturn(true);

      await binanceService.fetchBinance();

      verifyNever(mockGetCurrenciesUseCase.call);
    });

    test('call getBitcoin successfully', () async {
      when(mockGetBitcoinUseCase.call).thenAnswer(
        (final _) async => Either.right(Bitcoin.dummy()),
      );

      final binance = await binanceService.getBitcoin();

      verify(mockGetBitcoinUseCase.call).called(1);
      expect(binance, isA<Bitcoin>());
    });

    test('call getBitcoin with error', () async {
      when(mockGetBitcoinUseCase.call).thenAnswer(
        (final _) async => Either.left(const ServerFailure('error')),
      );

      expect(
        () async => binanceService.getBitcoin(),
        throwsA(isA<FetchException>()),
      );
    });

    test('call getCurrencies successfully', () async {
      when(mockGetCurrenciesUseCase.call).thenAnswer(
        (final _) async => Either.right(Binance.dummyGen().lock),
      );

      final binance = await binanceService.getCurrencies();

      verify(mockGetCurrenciesUseCase.call).called(1);
      expect(binance, isA<IList<Binance>>());
    });

    test('call getCurrencies with error', () async {
      when(mockGetCurrenciesUseCase.call).thenAnswer(
        (final _) async => Either.left(const ServerFailure('error')),
      );

      expect(
        () async => binanceService.getCurrencies(),
        throwsA(isA<FetchException>()),
      );
    });

    test('call paginateBinance', () async {
      when(mockGetCurrenciesUseCase.call).thenAnswer(
        (final _) async => Either.right(Binance.dummyGen().lock),
      );

      await binanceService.fetchBinance();
      binanceService.paginateBinance(mockQuery);

      verify(() => mockQuery.setData(any())).called(1);
    });

    test('call refreshBinance', () async {
      when(mockQuery.reset).thenAnswer((final _) async => Future.value());
      when(mockQuery.refresh).thenAnswer((final _) async => Future.value());

      binanceService.refreshBinance(mockQuery);

      verify(mockQuery.reset).called(1);
      verify(mockQuery.refresh).called(1);
    });
  });
}
