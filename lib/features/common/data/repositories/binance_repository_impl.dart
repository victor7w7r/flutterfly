import 'package:dio/dio.dart' show DioException;
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart' show Task, TaskEither;
import 'package:injectable/injectable.dart' show Injectable;

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/features/common/business/entities/binance.dart';
import 'package:flutterfly/features/common/business/repositories/binance_repository.dart';
import 'package:flutterfly/features/common/data/datasources/binance_remote_data_source.dart';

@Injectable(as: BinanceRepository)
final class BinanceRepositoryImpl implements BinanceRepository {
  const BinanceRepositoryImpl(this._binanceDataSource);

  final BinanceRemoteDataSource _binanceDataSource;

  @override
  TaskEither<Failure, IList<Binance>> getCurrencies() => TaskEither.tryCatch(
        Task(_binanceDataSource.getCurrencies)
            .map((final list) => list.lock)
            .run,
        (final e, final s) =>
            ServerFailure((e as DioException).message ?? 'Server Error'),
      );
}
