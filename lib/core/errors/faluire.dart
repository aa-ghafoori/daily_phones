import 'package:daily_phones/core/errors/exceptions.dart';
import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  factory ServerFailure.fromException(ServerException exception) =>
      ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  factory ApiFailure.fromException(ApiException exception) => ApiFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      );
}
