import 'unset_env_error.dart';

class _EnvKeys {
  _EnvKeys._internal();

  static const fontsApiUrl = 'FONTS_API_URL';

  static const httpClientConnectTimeoutSeconds =
      'HTTP_CLIENT_CONNECT_TIMEOUT_SECONDS';

  static const httpClientReceiveTimeoutSeconds =
      'HTTP_CLIENT_RECEIVE_TIMEOUT_SECONDS';
}

class Env {
  factory Env() => _instance ??= Env._internal();

  Env._internal();

  static Env? _instance;

  static const Map<String, dynamic> _keys = {
    _EnvKeys.fontsApiUrl: String.fromEnvironment(_EnvKeys.fontsApiUrl),
    _EnvKeys.httpClientConnectTimeoutSeconds:
        int.fromEnvironment(_EnvKeys.httpClientConnectTimeoutSeconds),
    _EnvKeys.httpClientReceiveTimeoutSeconds:
        int.fromEnvironment(_EnvKeys.httpClientReceiveTimeoutSeconds),
  };

  static T _getKey<T>(String key) {
    final value = _keys[key];
    if (value.runtimeType != T) {
      throw UnsetEnvError('$key is not set in Env');
    }
    return value as T;
  }

  String get fontsApi => _getKey<String>(_EnvKeys.fontsApiUrl);

  int get httpClientConnectTimeoutSeconds =>
      _getKey<int>(_EnvKeys.httpClientConnectTimeoutSeconds);

  int get httpClientReceiveTimeoutSeconds =>
      _getKey<int>(_EnvKeys.httpClientReceiveTimeoutSeconds);
}
