import 'package:fast_immutable_collections/fast_immutable_collections.dart'
    show IList;

import 'package:fpdart/fpdart.dart' show Either;
import 'package:injectable/injectable.dart' show injectable;

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/core/usecase/usecase.dart';
import 'package:flutterfly/features/common/business/entities/entities.dart';
import 'package:flutterfly/features/common/business/repositories/repositories.dart';

@injectable
final class GetCurrenciesUseCase
    implements UseCase<Either<Failure, IList<Binance>>, void> {
  const GetCurrenciesUseCase(this._repository);

  final BinanceRepository _repository;

  @override
  Future<Either<Failure, IList<Binance>>> call({final void params}) =>
      _repository.getCurrencies().run();
}
