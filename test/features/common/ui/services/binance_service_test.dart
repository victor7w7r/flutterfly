import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fl_query/fl_query.dart' show Query;
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/core/error/fetch_exception.dart';
import 'package:flutterfly/core/utils/platforms.dart';
import 'package:flutterfly/features/common/business/entities/entities.dart';
import 'package:flutterfly/features/common/business/usecases/usecases.dart';
import 'package:flutterfly/features/common/ui/services/binance_service.dart';

class MockGetCurrenciesUseCase extends Mock implements GetCurrenciesUseCase {}

class MockGetBitcoinUseCase extends Mock implements GetBitcoinUseCase {}

class MockQuery extends Mock implements Query<List<Binance>, FetchException> {}

class MockPlatform extends Mock implements Platform {}

void main() {
  group('BinanceService', () {
    late BinanceService binanceService;
    late MockGetCurrenciesUseCase mockGetCurrenciesUseCase;
    late MockGetBitcoinUseCase mockGetBitcoinUseCase;
    late MockPlatform mockPlatform;
    late MockQuery mockQuery;

    setUp(() {
      mockGetCurrenciesUseCase = MockGetCurrenciesUseCase();
      mockGetBitcoinUseCase = MockGetBitcoinUseCase();
      mockQuery = MockQuery();
      mockPlatform = MockPlatform();
      binanceService = BinanceService(
        mockGetCurrenciesUseCase,
        mockGetBitcoinUseCase,
        mockPlatform,
      );
      when(mockPlatform.isWeb).thenReturn(false);
    });

    test('Call fetchBinance', () async {
      when(mockGetCurrenciesUseCase.call).thenAnswer(
        (final _) async => Either.right(Binance.dummyGen().lock),
      );

      await binanceService.fetchBinance();
      verify(mockGetCurrenciesUseCase.call).called(1);
    });

    test('Call fetchBinance with web interface', () async {
      when(mockPlatform.isWeb).thenReturn(true);

      await binanceService.fetchBinance();
      verifyNever(mockGetCurrenciesUseCase.call);
    });

    test('Call getBitcoin successfully', () async {
      when(mockGetBitcoinUseCase.call).thenAnswer(
        (final _) async => Either.right(Bitcoin.dummy()),
      );

      final binance = await binanceService.getBitcoin();
      verify(mockGetBitcoinUseCase.call).called(1);

      expect(binance, isA<Bitcoin>());
    });

    test('Call getBitcoin with error', () async {
      when(mockGetBitcoinUseCase.call).thenAnswer(
        (final _) async => Either.left(const ServerFailure('error')),
      );

      expect(
        () async => binanceService.getBitcoin(),
        throwsA(isA<FetchException>()),
      );
    });

    test('Call getCurrencies successfully', () async {
      when(mockGetCurrenciesUseCase.call).thenAnswer(
        (final _) async => Either.right(Binance.dummyGen().lock),
      );

      final binance = await binanceService.getCurrencies();
      verify(mockGetCurrenciesUseCase.call).called(1);

      expect(binance, isA<IList<Binance>>());
    });

    test('Call getCurrencies with error', () async {
      when(mockGetCurrenciesUseCase.call).thenAnswer(
        (final _) async => Either.left(const ServerFailure('error')),
      );

      expect(
        () async => binanceService.getCurrencies(),
        throwsA(isA<FetchException>()),
      );
    });

    test('Call paginateBinance', () async {
      when(mockGetCurrenciesUseCase.call).thenAnswer(
        (final _) async => Either.right(Binance.dummyGen().lock),
      );

      await binanceService.fetchBinance();

      binanceService.paginateBinance(mockQuery);
      verify(() => mockQuery.setData(any())).called(1);
    });

    test('Call refreshBinance', () async {
      when(mockQuery.reset).thenAnswer((final _) async => Future.value());
      when(mockQuery.refresh).thenAnswer((final _) async => Future.value());

      binanceService.refreshBinance(mockQuery);

      verify(mockQuery.reset).called(1);
      verify(mockQuery.refresh).called(1);
    });
  });
}
