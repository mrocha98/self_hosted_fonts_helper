import '../core/module/module.dart';
import 'settings_view.dart';

class SettingsModule extends Module {
  SettingsModule()
      : super(
          // SettingsController is provided in app_module so is not
          // necessary to provide anything in this module bindings
          routes: {
            SettingsView.routeName: (context) => const SettingsView(),
          },
        );
}
