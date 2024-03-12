import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
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
