import 'package:dio/dio.dart' show DioException;
import 'package:fpdart/fpdart.dart' show TaskEither;
import 'package:injectable/injectable.dart' show Injectable;

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/business/repositories/binance_repository.dart';
import 'package:flutterfly/features/common/data/datasources/binance_remote_data_source.dart';

@Injectable(as: BinanceRepository)
class BinanceRepositoryImpl implements BinanceRepository {
  const BinanceRepositoryImpl(this._binanceDataSource);

  final BinanceRemoteDataSource _binanceDataSource;

  @override
  TaskEither<Failure, List<Binance>> getCurrencies() => TaskEither.tryCatch(
        _binanceDataSource.getCurrencies,
        (final e, final s) =>
            ServerFailure((e as DioException).message ?? 'Server Error'),
      );
}
