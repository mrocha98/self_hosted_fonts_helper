import 'package:flutter/material.dart';

import '../../repositories/theme_mode/theme_mode_repository.dart';
import 'theme_mode_service.dart';

class ThemeModeServiceImpl implements ThemeModeService {
  ThemeModeServiceImpl(this._themeModeRepository);

  final ThemeModeRepository _themeModeRepository;

  @override
  Future<ThemeMode> getThemeMode() async {
    final cachedThemeMode = await _themeModeRepository.getThemeMode();
    return cachedThemeMode ?? ThemeMode.system;
  }

  @override
  Future<void> save(ThemeMode themeMode) =>
      _themeModeRepository.save(themeMode);
}
