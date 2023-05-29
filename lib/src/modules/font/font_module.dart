import 'package:provider/provider.dart';

import '../../core/module/module.dart';
import 'font_controller.dart';
import 'font_view.dart';

class FontModule extends Module {
  FontModule()
      : super(
          routes: {
            FontView.routeName: (context) => const FontView(),
          },
          bindings: [
            ChangeNotifierProvider(
              create: (context) => FontController(),
            )
          ],
        );
}
