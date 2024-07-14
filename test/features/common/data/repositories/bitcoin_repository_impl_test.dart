import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/data/datasources/binance_remote_data_source.dart';
import 'package:flutterfly/features/common/data/dto/bitcoin_dto.dart';
import 'package:flutterfly/features/common/data/repositories/bitcoin_repository_impl.dart';

final class MockBitcoinDataSource extends Mock
    implements BinanceRemoteDataSource {}

void main() {
  group('BitcoinRepositoryImpl', () {
    late BinanceRemoteDataSource dataSource;
    late BitcoinRepositoryImpl repository;

    setUp(() {
      dataSource = MockBitcoinDataSource();
      repository = BitcoinRepositoryImpl(dataSource);
    });

    test('should return a BitcoinPrice successfully', () async {
      const bitcoinDto = BitcoinDto('BTCUSDT', '10000');
      when(dataSource.getBitcoin).thenAnswer((final _) async => bitcoinDto);

      final result = await repository.getBitcoin().run();

      expect(result.getRight().toNullable(), bitcoinDto);
      verify(dataSource.getBitcoin).called(1);
    });

    test('should throw a ServerException when the call is unsuccessful',
        () async {
      when(dataSource.getBitcoin).thenThrow(
        DioException(requestOptions: RequestOptions()),
      );

      final result = await repository.getBitcoin().run();

      expect(result.getLeft().toNullable(), isA<ServerFailure>());
      verify(dataSource.getBitcoin).called(1);
    });
  });
}
