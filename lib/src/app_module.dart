import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_widget.dart';
import 'core/database/key_value_storage/key_value_storage.dart';
import 'core/database/key_value_storage/key_value_storage_get_storage_impl.dart';
import 'core/env/env.dart';
import 'core/http_client/http_client.dart';
import 'core/http_client/http_client_dio_impl.dart';
import 'modules/settings/settings_controller.dart';
import 'repositories/locale/locale_repository.dart';
import 'repositories/locale/locale_repository_impl.dart';
import 'repositories/theme_mode/theme_mode_repository.dart';
import 'repositories/theme_mode/theme_mode_repository_impl.dart';
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
        Provider<KeyValueStorage>(
          create: (context) => KeyValueStorageGetStorageImpl(),
        ),
        Provider<HttpClient>(
          create: (context) => HttpClientDioImpl(context.read<Env>()),
        ),
        Provider<LocaleRepository>(
          create: (context) => LocaleRepositoryImpl(
            context.read<KeyValueStorage>(),
          ),
        ),
        Provider<LocaleService>(
          create: (context) => LocaleServiceImpl(
            context.read<LocaleRepository>(),
          ),
        ),
        Provider<ThemeModeRepository>(
          create: (context) => ThemeModeRepositoryImpl(
            context.read<KeyValueStorage>(),
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
      ],
      child: const AppWidget(),
    );
  }
}
