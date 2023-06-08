import 'dart:collection';

import 'package:clock/clock.dart';
import 'package:get_storage/get_storage.dart';
import 'key_value_storage.dart';

sealed class KeyValueStorageGetStorageImpl implements KeyValueStorage {
  KeyValueStorageGetStorageImpl({required String container})
      : _container = container;

  static final Set<String> _containers = HashSet();

  final String _container;

  GetStorage get _storage => GetStorage(_container);

  @override
  Future<void> init([dynamic args]) async {
    final isContainerInactive = _containers.add(_container);
    if (isContainerInactive) {
      await GetStorage.init(_container);
    }
  }

  @override
  Future<V?> get<V>(String key) async {
    final expirationDate = _getExpirationDate(key);
    if (expirationDate != null && _expired(expirationDate)) {
      await remove(key);
      return null;
    }
    return _storage.read<V>(key);
  }

  @override
  Future<List<V>?> getList<V>(String key) async {
    final content = await get<Iterable<dynamic>>(key);
    if (content == null) return null;
    return List<V>.from(content);
  }

  @override
  Future<bool> hasData(String key) =>
      get<dynamic>(key).then((value) => value != null);

  @override
  Future<void> remove(String key) => Future.wait([
        _storage.remove(key),
        _storage.remove(_getExpirationKey(key)),
      ]);

  @override
  Future<void> set<V>(String key, V? value, {DateTime? expiresOn}) async {
    await _storage.write(key, value);
    if (expiresOn != null) {
      await _storage.write(
        _getExpirationKey(key),
        expiresOn.toIso8601String(),
      );
    }
  }

  String _getExpirationKey(String key) => '$key-expiration';

  DateTime? _getExpirationDate(String key) {
    final expirationKey = _getExpirationKey(key);
    final expirationDate = _storage.read<String>(expirationKey);
    if (expirationDate != null) {
      return DateTime.tryParse(expirationDate);
    }
    return null;
  }

  bool _expired(DateTime expirationDate) =>
      expirationDate.isBefore(clock.now());
}

final class KeyValueStorageGetStorageImplSettingsContainer
    extends KeyValueStorageGetStorageImpl {
  factory KeyValueStorageGetStorageImplSettingsContainer() =>
      _instance ??= KeyValueStorageGetStorageImplSettingsContainer._internal();

  KeyValueStorageGetStorageImplSettingsContainer._internal()
      : super(container: 'settings');

  static KeyValueStorageGetStorageImplSettingsContainer? _instance;
}

final class KeyValueStorageGetStorageImplFontsContainer
    extends KeyValueStorageGetStorageImpl {
  factory KeyValueStorageGetStorageImplFontsContainer() =>
      _instance ??= KeyValueStorageGetStorageImplFontsContainer._internal();

  KeyValueStorageGetStorageImplFontsContainer._internal()
      : super(container: 'fonts');

  static KeyValueStorageGetStorageImplFontsContainer? _instance;
}
