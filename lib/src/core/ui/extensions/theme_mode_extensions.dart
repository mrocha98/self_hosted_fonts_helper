import 'package:flutter/material.dart';

import '../../locale/app_localizations.dart';

extension ThemeModeExtensions on ThemeMode {
  String getLocalizedName(BuildContext context) {
    final localizedNames = {
      ThemeMode.system: AppLocalizations.of(context)!.themeOptionSystem,
      ThemeMode.dark: AppLocalizations.of(context)!.themeOptionDark,
      ThemeMode.light: AppLocalizations.of(context)!.themeOptionLight,
    };
    return localizedNames[this] ?? '';
  }
}
