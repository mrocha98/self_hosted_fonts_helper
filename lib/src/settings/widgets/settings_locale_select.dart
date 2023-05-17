import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:intl/intl.dart';
import 'package:locale_emoji_flutter/locale_emoji_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/locale/app_localizations.dart';
import '../../core/locale/supported_locales.dart';
import '../settings_controller.dart';

class SettingsLocaleSelect extends StatelessWidget {
  const SettingsLocaleSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Locale?>(
      isExpanded: true,
      items: [
        DropdownMenuItem<Locale?>(
          value: Locale(Intl.systemLocale),
          child: Text(
            AppLocalizations.of(context)!.localeOptionSystem,
          ),
        ),
        ...supportedLocales.map(
          (locale) {
            final localeName =
                LocaleNames.of(context)!.nameOf(locale.toString()) ??
                    locale.languageCode;
            final flag = locale.flagEmoji ?? '';
            return DropdownMenuItem(
              value: locale,
              child: Text(
                '$flag $localeName'.trimLeft(),
                overflow: TextOverflow.ellipsis,
              ),
            );
          },
        ),
      ],
      onChanged: (locale) =>
          context.read<SettingsController>().changeLocale(locale),
      value: context.select<SettingsController, Locale?>(
        (settings) => settings.locale,
      ),
    );
  }
}
