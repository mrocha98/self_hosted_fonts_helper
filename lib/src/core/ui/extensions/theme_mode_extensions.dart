import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
