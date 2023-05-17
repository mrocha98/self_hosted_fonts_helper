import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/settings_locale_select.dart';
import 'widgets/settings_theme_select_option.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pageSettingsTitle),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.inversePrimary,
                width: 2,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.themeLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              ...ThemeMode.values.map(
                SettingsThemeSelectOption.new,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AppLocalizations.of(context)!.localeLabel,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SettingsLocaleSelect(),
            ],
          ),
        ),
      ),
    );
  }
}
