abstract interface class KeyValueStorage {
  /// init storage with optional [args]
  Future<void> init([dynamic args]);

  /// search [key] in storage and return the associated value if exists
  /// else return null
  Future<V?> get<V>(String key);

  /// search [key] in storage and return the associated list if exists
  /// else return null
  Future<List<V>?> getList<V>(String key);

  /// store the [value] in the [key] index
  Future<void> set<V>(String key, V? value, {DateTime? expiresOn});

  /// checks if the [key] contains a non-nullable value
  Future<bool> hasData(String key);

  /// delete the entry with [key] from storage
  Future<void> remove(String key);
}
