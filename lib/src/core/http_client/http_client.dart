import 'http_client_response.dart';
import 'http_client_response_type.dart';

abstract interface class HttpClient {
  String get baseUrl;

  Future<HttpClientResponse<T>> get<T>(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    HttpClientResponseType? responseType,
    String? contentType,
  });
}
