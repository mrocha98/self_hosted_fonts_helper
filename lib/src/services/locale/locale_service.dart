import 'dart:ui';

abstract interface class LocaleService {
  Future<void> save(Locale? locale);
  Future<Locale?> getLocale();
}
