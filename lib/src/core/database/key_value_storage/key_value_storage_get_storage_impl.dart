import 'package:clock/clock.dart';
import 'package:get_storage/get_storage.dart';
import 'key_value_storage.dart';

class KeyValueStorageGetStorageImpl implements KeyValueStorage {
  @override
  Future<V?> get<V>(String key) async {
    final expirationDate = _getExpirationDate(key);
    if (expirationDate != null && _expired(expirationDate)) {
      await remove(key);
      return null;
    }
    return GetStorage().read<V>(key);
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
        GetStorage().remove(key),
        GetStorage().remove(_getExpirationKey(key)),
      ]);

  @override
  Future<void> set<V>(String key, V? value, {DateTime? expiresOn}) async {
    await GetStorage().write(key, value);
    if (expiresOn != null) {
      await GetStorage().write(
        _getExpirationKey(key),
        expiresOn.toIso8601String(),
      );
    }
  }

  String _getExpirationKey(String key) => '$key-expiration';

  DateTime? _getExpirationDate(String key) {
    final expirationKey = _getExpirationKey(key);
    final expirationDate = GetStorage().read<String>(expirationKey);
    if (expirationDate != null) {
      return DateTime.tryParse(expirationDate);
    }
    return null;
  }

  bool _expired(DateTime expirationDate) =>
      expirationDate.isBefore(clock.now());
}
