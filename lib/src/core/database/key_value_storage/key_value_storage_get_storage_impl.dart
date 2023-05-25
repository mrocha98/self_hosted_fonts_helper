import 'package:get_storage/get_storage.dart';
import 'key_value_storage.dart';

class KeyValueStorageGetStorageImpl implements KeyValueStorage {
  @override
  Future<V?> get<V>(String key) async => GetStorage().read<V?>(key);

  @override
  Future<bool> hasData(String key) async => GetStorage().hasData(key);

  @override
  Future<void> remove(String key) async => GetStorage().remove(key);

  @override
  Future<void> set<V>(String key, V? value) => GetStorage().write(key, value);
}
