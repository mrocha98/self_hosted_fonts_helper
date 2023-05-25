import 'package:meta/meta.dart';

@immutable
class HttpClientResponse<T> {
  const HttpClientResponse({
    required this.data,
    this.statusCode,
    this.statusMessage,
  });

  final T data;

  final int? statusCode;

  final String? statusMessage;

  HttpClientResponse<T> copyWith({
    T? data,
    int? statusCode,
    String? statusMessage,
  }) {
    return HttpClientResponse<T>(
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  String toString() => 'HttpClientResponse('
      'data: $data, '
      'statusCode: $statusCode, '
      'statusMessage: $statusMessage'
      ')';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HttpClientResponse<T> &&
        other.data == data &&
        other.statusCode == statusCode &&
        other.statusMessage == statusMessage;
  }

  @override
  int get hashCode =>
      data.hashCode ^ statusCode.hashCode ^ statusMessage.hashCode;
}
