// Created by Juan David Romero.

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException(message: $message, statusCode: $statusCode)';
}
