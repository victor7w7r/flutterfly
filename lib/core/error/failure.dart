import 'package:dart_mappable/dart_mappable.dart';

part '../../../../generated/core/error/failure.mapper.dart';

@MappableClass(
  generateMethods: GenerateMethods.stringify | GenerateMethods.equals,
)
abstract class Failure with FailureMappable {
  const Failure(this.message);

  final String message;
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

final class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

final class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}
