import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'src/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const AppModule());
}
