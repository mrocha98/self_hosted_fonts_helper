import 'package:dio/dio.dart';

import '../env/env.dart';
import 'http_client.dart';
import 'http_client_exception.dart';
import 'http_client_response.dart';

class HttpClientDioImpl implements HttpClient {
  HttpClientDioImpl(this._env) {
    _dio = Dio(_defaultOptions);
  }

  late final Dio _dio;

  final Env _env;

  BaseOptions get _defaultOptions => BaseOptions(
        baseUrl: _env.fontsApi,
        connectTimeout: Duration(seconds: _env.httpClientConnectTimeoutSeconds),
        receiveTimeout: Duration(seconds: _env.httpClientReceiveTimeoutSeconds),
      );

  @override
  String get baseUrl => _env.fontsApi;

  @override
  Future<HttpClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioError catch (error) {
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

  HttpClientException<dynamic> _dioErrorConverter(DioError error) =>
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
}
