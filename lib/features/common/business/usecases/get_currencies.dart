import 'package:fpdart/fpdart.dart' show Either;
import 'package:injectable/injectable.dart' show injectable;

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/core/usecase/usecase.dart';
import 'package:flutterfly/features/common/business/entities/entities.dart';
import 'package:flutterfly/features/common/business/repositories/repositories.dart';

@injectable
class GetCurrenciesUseCase
    implements UseCase<Either<Failure, List<Binance>>, void> {
  GetCurrenciesUseCase(this._repository);

  final BinanceRepository _repository;

  @override
  Future<Either<Failure, List<Binance>>> call({final void params}) =>
      _repository.getCurrencies().run();
}
