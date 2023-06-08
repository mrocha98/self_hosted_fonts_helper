import 'package:dio/dio.dart';

import '../env/env.dart';
import 'http_client.dart';
import 'http_client_exception.dart';
import 'http_client_response.dart';
import 'http_client_response_type.dart';

class HttpClientDioImpl implements HttpClient {
  HttpClientDioImpl(this._env) {
    _dio = Dio(_defaultOptions)..interceptors.add(LogInterceptor());
  }

  late final Dio _dio;

  final Env _env;

  BaseOptions get _defaultOptions => BaseOptions(
        connectTimeout: Duration(seconds: _env.httpClientConnectTimeoutSeconds),
        receiveTimeout: Duration(seconds: _env.httpClientReceiveTimeoutSeconds),
      );

  @override
  String get baseUrl => _env.fontsApi;

  @override
  Future<HttpClientResponse<T>> get<T>(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    HttpClientResponseType? responseType,
    String? contentType,
  }) async {
    final parsedPath = useBaseUrl ? '$baseUrl$path' : path;
    try {
      final response = await _dio.get<T>(
        parsedPath,
        queryParameters: queryParameters,
        options: Options(
          contentType: contentType,
          headers: headers,
          responseType: _httpClientResponseTypeConverter(responseType),
        ),
      );
      return _dioResponseConverter(response);
    } on DioException catch (error) {
      throw _dioErrorConverter(error);
    }
  }

  Future<HttpClientResponse<T>> _dioResponseConverter<T>(
    Response<dynamic> response,
  ) async =>
      HttpClientResponse(
        data: response.data as T,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
      );

  HttpClientException<dynamic> _dioErrorConverter(DioException error) =>
      HttpClientException(
        error: error,
        response: HttpClientResponse(
          data: error.response?.data,
          statusCode: error.response?.statusCode,
          statusMessage: error.response?.statusMessage,
        ),
        message: error.message,
        statusCode: error.response?.statusCode,
      );

  ResponseType? _httpClientResponseTypeConverter(
    HttpClientResponseType? httpClientResponseType,
  ) =>
      switch (httpClientResponseType) {
        HttpClientResponseType.json => ResponseType.json,
        HttpClientResponseType.bytes => ResponseType.bytes,
        _ => null,
      };
}
