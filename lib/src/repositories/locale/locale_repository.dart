import 'dart:ui';

abstract interface class LocaleRepository {
  Future<void> save(Locale? locale);
  Future<Locale?> getLocale();
}
