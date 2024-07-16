import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.message,
    String? statusCode,
  }) : statusCode = statusCode ?? '500';

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiException extends Equatable implements Exception {
  const ApiException({
    required this.message,
    this.statusCode = '500',
  });

  final String message;
  final String statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}
