import 'package:fpdart/fpdart.dart' show Either;
import 'package:injectable/injectable.dart' show injectable;

import 'package:flutterfly/core/error/failure.dart';
import 'package:flutterfly/core/usecase/usecase.dart';
import 'package:flutterfly/features/common/business/entities/entities.dart';
import 'package:flutterfly/features/common/business/repositories/repositories.dart';

@injectable
class GetBitcoinUseCase implements UseCase<Either<Failure, Bitcoin>, void> {
  GetBitcoinUseCase(this._repository);

  final BitcoinRepository _repository;

  @override
  Future<Either<Failure, Bitcoin>> call({final void params}) =>
      _repository.getBitcoin().run();
}
