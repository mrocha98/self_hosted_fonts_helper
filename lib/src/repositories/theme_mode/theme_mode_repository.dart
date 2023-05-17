import 'package:flutter/material.dart';

abstract interface class ThemeModeRepository {
  Future<void> save(ThemeMode themeMode);
  Future<ThemeMode?> getThemeMode();
}
