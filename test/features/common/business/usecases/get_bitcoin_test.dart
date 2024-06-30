import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/business/entities/bitcoin.dart';
import 'package:flutterfly/features/common/business/repositories/bitcoin_repository.dart';
import 'package:flutterfly/features/common/business/usecases/get_bitcoin.dart';

class MockBitcoinRepository extends Mock implements BitcoinRepository {}

void main() {
  group('GetBitcoinUseCase', () {
    late GetBitcoinUseCase getBitcoinUseCase;
    late MockBitcoinRepository mockBitcoinRepository;

    setUp(() {
      mockBitcoinRepository = MockBitcoinRepository();
      getBitcoinUseCase = GetBitcoinUseCase(mockBitcoinRepository);
    });

    test('Call should return a bitcoin', () async {
      final bitcoin = Bitcoin.dummy();

      when(() => mockBitcoinRepository.getBitcoin()).thenAnswer(
        (final _) => TaskEither<Failure, Bitcoin?>.right(bitcoin),
      );

      final result = await getBitcoinUseCase.call();

      expect(result.getRight().toNullable(), equals(bitcoin));

      verify(() => mockBitcoinRepository.getBitcoin()).called(1);
      verifyNoMoreInteractions(mockBitcoinRepository);
    });

    test('Call should return a failure', () async {
      const failure = ServerFailure('Server Failure');

      when(() => mockBitcoinRepository.getBitcoin()).thenAnswer(
        (final _) => TaskEither<Failure, Bitcoin?>.left(failure),
      );

      final result = await getBitcoinUseCase.call();

      expect(result.getLeft().toNullable(), equals(failure));

      verify(() => mockBitcoinRepository.getBitcoin()).called(1);
      verifyNoMoreInteractions(mockBitcoinRepository);
    });
  });
}
