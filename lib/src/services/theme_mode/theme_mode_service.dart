import 'package:flutter/material.dart';

abstract interface class ThemeModeService {
  Future<void> save(ThemeMode themeMode);
  Future<ThemeMode> getThemeMode();
}
