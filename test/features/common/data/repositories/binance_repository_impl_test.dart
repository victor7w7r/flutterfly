import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/data/datasources/binance_remote_data_source.dart';
import 'package:flutterfly/features/common/data/dto/binance_dto.dart';
import 'package:flutterfly/features/common/data/repositories/binance_repository_impl.dart';

class MockBinanceDataSource extends Mock implements BinanceRemoteDataSource {}

void main() {
  group('BinanceRepositoryImpl', () {
    late BinanceRemoteDataSource dataSource;
    late BinanceRepositoryImpl repository;

    setUp(() {
      dataSource = MockBinanceDataSource();
      repository = BinanceRepositoryImpl(dataSource);
    });

    test('should return a CurrencyList successfully', () async {
      final listBinanceDto = <BinanceDto>[];

      when(dataSource.getCurrencies)
          .thenAnswer((final _) async => listBinanceDto);

      final result = await repository.getCurrencies().run();

      expect(result.getRight().toNullable(), listBinanceDto);
      verify(dataSource.getCurrencies).called(1);
    });

    test('should throw a ServerException when the call is unsuccessful',
        () async {
      when(dataSource.getCurrencies).thenThrow(
        DioException(requestOptions: RequestOptions()),
      );

      final result = await repository.getCurrencies().run();

      expect(result.getLeft().toNullable(), isA<ServerFailure>());
      verify(dataSource.getCurrencies).called(1);
    });
  });
}
