import 'package:flutter/material.dart';

import '../services/locale/locale_service.dart';
import '../services/theme_mode/theme_mode_service.dart';
import 'settings_model.dart';

class SettingsController extends ChangeNotifier {
  SettingsController(
    this._localeService,
    this._themeModeService,
  );

  final LocaleService _localeService;

  final ThemeModeService _themeModeService;

  SettingsModel _settings = const SettingsModel.initial();

  Locale? get locale => _settings.locale;

  Future<void> changeLocale(Locale? locale) async {
    await _localeService.save(locale);
    _settings = _settings.copyWith(locale: locale);
    notifyListeners();
  }

  ThemeMode get themeMode => _settings.themeMode;

  Future<void> changeThemeMode(ThemeMode themeMode) async {
    await _themeModeService.save(themeMode);
    _settings = _settings.copyWith(theme: themeMode);
    notifyListeners();
  }

  Future<void> initialize() async {
    final futures = await Future.wait([
      _localeService.getLocale(),
      _themeModeService.getThemeMode(),
    ]);
    final locale = futures.first as Locale?;
    final themeMode = futures.last! as ThemeMode;

    await Future.wait([
      changeLocale(locale),
      changeThemeMode(themeMode),
    ]);

    notifyListeners();
  }
}
