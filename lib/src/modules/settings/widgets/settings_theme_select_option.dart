import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/extensions/theme_mode_extensions.dart';
import '../settings_controller.dart';

class SettingsThemeSelectOption extends StatelessWidget {
  const SettingsThemeSelectOption(
    this.themeMode, {
    super.key,
  });

  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Selector<SettingsController, ThemeMode>(
      selector: (context, controller) => controller.themeMode,
      builder: (context, groupValue, _) {
        return RadioListTile(
          value: themeMode,
          groupValue: groupValue,
          onChanged: (newThemeMode) async {
            if (newThemeMode == null) return;
            await context
                .read<SettingsController>()
                .changeThemeMode(newThemeMode);
          },
          title: Text(
            themeMode.getLocalizedName(context),
          ),
        );
      },
    );
  }
}
