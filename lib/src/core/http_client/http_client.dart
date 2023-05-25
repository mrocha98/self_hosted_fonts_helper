import 'http_client_response.dart';

abstract interface class HttpClient {
  String get baseUrl;

  Future<HttpClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
