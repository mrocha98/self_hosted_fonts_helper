import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'core/database/key_value_storage/key_value_storage_get_storage_impl.dart';
import 'core/env/env.dart';
import 'core/http_client/http_client.dart';
import 'core/http_client/http_client_dio_impl.dart';
import 'core/logger/logger.dart';
import 'core/logger/logger_talker_impl.dart';
import 'modules/fonts_filter/fonts_filter_controller.dart';
import 'modules/settings/settings_controller.dart';
import 'repositories/fonts/fonts_repository.dart';
import 'repositories/fonts/fonts_repository_impl.dart';
import 'repositories/locale/locale_repository.dart';
import 'repositories/locale/locale_repository_impl.dart';
import 'repositories/theme_mode/theme_mode_repository.dart';
import 'repositories/theme_mode/theme_mode_repository_impl.dart';
import 'services/fonts/fonts_service.dart';
import 'services/fonts/fonts_service_impl.dart';
import 'services/locale/locale_service.dart';
import 'services/locale/locale_service_impl.dart';
import 'services/theme_mode/theme_mode_service.dart';
import 'services/theme_mode/theme_mode_service_impl.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Env>(
          create: (context) => Env(),
        ),
        Provider<Logger>(
          create: (context) => LoggerTalkerImpl(),
          lazy: false,
        ),
        Provider<KeyValueStorageGetStorageImplSettingsContainer>(
          create: (context) => KeyValueStorageGetStorageImplSettingsContainer(),
        ),
        Provider<KeyValueStorageGetStorageImplFontsContainer>(
          create: (context) => KeyValueStorageGetStorageImplFontsContainer(),
        ),
        Provider<HttpClient>(
          create: (context) => HttpClientDioImpl(context.read<Env>()),
        ),
        Provider<LocaleRepository>(
          create: (context) => LocaleRepositoryImpl(
            context.read<KeyValueStorageGetStorageImplSettingsContainer>(),
          ),
        ),
        Provider<LocaleService>(
          create: (context) => LocaleServiceImpl(
            context.read<LocaleRepository>(),
          ),
        ),
        Provider<ThemeModeRepository>(
          create: (context) => ThemeModeRepositoryImpl(
            context.read<KeyValueStorageGetStorageImplSettingsContainer>(),
          ),
        ),
        Provider<ThemeModeService>(
          create: (context) => ThemeModeServiceImpl(
            context.read<ThemeModeRepository>(),
          ),
        ),
        ChangeNotifierProvider<SettingsController>(
          create: (context) => SettingsController(
            context.read<LocaleService>(),
            context.read<ThemeModeService>(),
          ),
        ),
        Provider<FontsRepository>(
          create: (context) => FontsRepositoryImpl(
            context.read<HttpClient>(),
            context.read<Logger>(),
          ),
        ),
        Provider<FontsService>(
          create: (context) => FontsServiceImpl(
            context.read<FontsRepository>(),
            context.read<KeyValueStorageGetStorageImplFontsContainer>(),
          ),
        ),
        ChangeNotifierProvider<FontsFilterController>(
          create: (context) => FontsFilterController(
            context.read<FontsService>(),
          ),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
