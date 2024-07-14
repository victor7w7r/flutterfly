import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' show TaskEither;
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/business/repositories/binance_repository.dart';
import 'package:flutterfly/features/common/business/usecases/get_currencies.dart';

final class MockBinanceRepository extends Mock implements BinanceRepository {}

void main() {
  group('GetCurrenciesUseCase', () {
    late GetCurrenciesUseCase getCurrenciesUseCase;
    late MockBinanceRepository mockBinanceRepository;

    setUp(() {
      mockBinanceRepository = MockBinanceRepository();
      getCurrenciesUseCase = GetCurrenciesUseCase(mockBinanceRepository);
    });

    test('call should return currencies', () async {
      final curr = Binance.dummyGen().lock;

      when(() => mockBinanceRepository.getCurrencies()).thenAnswer(
        (final _) => TaskEither<Failure, IList<Binance>>.right(curr),
      );

      final result = await getCurrenciesUseCase.call();

      expect(result.getRight().toNullable()?.first, equals(curr.first));
      verify(() => mockBinanceRepository.getCurrencies()).called(1);
      verifyNoMoreInteractions(mockBinanceRepository);
    });

    test('call should return a failure', () async {
      const failure = ServerFailure('Server Failure');

      when(() => mockBinanceRepository.getCurrencies()).thenAnswer(
        (final _) => TaskEither<Failure, IList<Binance>>.left(failure),
      );

      final result = await getCurrenciesUseCase.call();

      expect(result.getLeft().toNullable(), equals(failure));
      verify(() => mockBinanceRepository.getCurrencies()).called(1);
      verifyNoMoreInteractions(mockBinanceRepository);
    });
  });
}
