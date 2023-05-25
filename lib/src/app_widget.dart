import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';

import 'core/locale/app_localizations.dart';
import 'core/locale/supported_locales.dart';
import 'core/ui/theme/dark_theme.dart';
import 'core/ui/theme/light_theme.dart';
import 'modules/home/home_module.dart';
import 'modules/settings/settings_controller.dart';
import 'modules/settings/settings_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final settings = context.read<SettingsController>();
      await settings.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',
      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocaleNamesLocalizationsDelegate(),
      ],
      supportedLocales: supportedLocales,
      locale: context.select<SettingsController, Locale?>(
        (settings) => settings.locale,
      ),
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: context.select<SettingsController, ThemeMode>(
        (settings) => settings.themeMode,
      ),
      routes: {
        ...HomeModule().routes,
        ...SettingsModule().routes,
      },
    );
  }
}
