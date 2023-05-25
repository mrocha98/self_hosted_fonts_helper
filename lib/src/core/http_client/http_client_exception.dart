import 'package:meta/meta.dart';

import 'http_client_response.dart';

@immutable
class HttpClientException<T> implements Exception {
  const HttpClientException({
    required this.error,
    required this.response,
    this.message,
    this.statusCode,
  });

  final String? message;

  final int? statusCode;

  final dynamic error;

  final HttpClientResponse<T> response;

  HttpClientException<T> copyWith({
    String? message,
    int? statusCode,
    dynamic error,
    HttpClientResponse<T>? response,
  }) {
    return HttpClientException<T>(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      error: error ?? this.error,
      response: response ?? this.response,
    );
  }

  @override
  String toString() {
    return 'HttpClientException('
        'message: $message, '
        'statusCode: $statusCode, '
        'error: $error, '
        'response: $response'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HttpClientException<T> &&
        other.message == message &&
        other.statusCode == statusCode &&
        other.error == error &&
        other.response == response;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        statusCode.hashCode ^
        error.hashCode ^
        response.hashCode;
  }
}
