import 'package:dio/dio.dart' show DioException;
import 'package:fpdart/fpdart.dart' show TaskEither;
import 'package:injectable/injectable.dart' show Injectable;

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/business/entities/bitcoin.dart';
import 'package:flutterfly/features/common/business/repositories/bitcoin_repository.dart';
import 'package:flutterfly/features/common/data/datasources/binance_remote_data_source.dart';

@Injectable(as: BitcoinRepository)
final class BitcoinRepositoryImpl implements BitcoinRepository {
  const BitcoinRepositoryImpl(this._binanceDataSource);

  final BinanceRemoteDataSource _binanceDataSource;

  @override
  TaskEither<Failure, Bitcoin?> getBitcoin() => TaskEither.tryCatch(
        _binanceDataSource.getBitcoin,
        (final e, final _) =>
            ServerFailure((e as DioException).message ?? 'Server Error'),
      );
}
