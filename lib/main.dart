import 'package:flutter/material.dart';

import 'src/app_module.dart';
import 'src/core/database/key_value_storage/key_value_storage_get_storage_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    KeyValueStorageGetStorageImplFontsContainer().init(),
    KeyValueStorageGetStorageImplSettingsContainer().init(),
  ]);
  runApp(const AppModule());
}
