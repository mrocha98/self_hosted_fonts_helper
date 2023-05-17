import 'dart:ui';

import './locale_repository.dart';
import '../../core/database/key_value_storage/key_value_storage.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  LocaleRepositoryImpl(this._kvStorage);

  final KeyValueStorage _kvStorage;

  String get _languageCodeKey => 'language_code';

  String get _countryCodeKey => 'country_code';

  @override
  Future<Locale?> getLocale() async {
    final languageCode = await _kvStorage.get<String>(_languageCodeKey);
    if (languageCode == null) return null;

    final countryCode = await _kvStorage.get<String>(_countryCodeKey);
    return Locale(languageCode, countryCode);
  }

  @override
  Future<void> save(Locale? locale) async {
    if (locale == null) {
      await Future.wait([
        _kvStorage.set(_languageCodeKey, null),
        _kvStorage.set(_countryCodeKey, null),
      ]);
    } else {
      await Future.wait([
        _kvStorage.set(_languageCodeKey, locale.languageCode),
        _kvStorage.set(_countryCodeKey, locale.countryCode),
      ]);
    }
  }
}
