import 'package:flutter/material.dart';

@immutable
class SettingsModel {
  const SettingsModel._internal({
    required this.themeMode,
    required this.locale,
  });

  const SettingsModel.initial()
      : themeMode = ThemeMode.system,
        locale = null;

  final ThemeMode themeMode;

  final Locale? locale;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsModel &&
        other.themeMode == themeMode &&
        other.locale == locale;
  }

  @override
  int get hashCode => themeMode.hashCode ^ locale.hashCode;

  @override
  String toString() => 'SettingsModel(themeMode: $themeMode, locale: $locale)';

  SettingsModel copyWith({
    ThemeMode? theme,
    Locale? locale,
  }) =>
      SettingsModel._internal(
        themeMode: theme ?? themeMode,
        locale: locale ?? this.locale,
      );
}
