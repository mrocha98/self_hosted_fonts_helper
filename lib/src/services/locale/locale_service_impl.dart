import 'dart:ui';

import '../../repositories/locale/locale_repository.dart';
import 'locale_service.dart';

class LocaleServiceImpl implements LocaleService {
  LocaleServiceImpl(this._localeRepository);

  final LocaleRepository _localeRepository;

  @override
  Future<Locale?> getLocale() => _localeRepository.getLocale();

  @override
  Future<void> save(Locale? locale) => _localeRepository.save(locale);
}
