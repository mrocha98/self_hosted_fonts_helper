import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/font_loader/font_loader_factory_type.dart';
import '../../core/module/module.dart';
import '../../services/fonts/fonts_service.dart';
import 'font_controller.dart';
import 'font_view.dart';

class FontModule extends Module {
  FontModule()
      : super(
          routes: {
            FontView.routeName: (context) => const FontView(),
          },
          bindings: [
            Provider<FontLoaderFactory>(
              create: (context) => FontLoader.new,
            ),
            ChangeNotifierProvider(
              create: (context) => FontController(
                context.read<FontsService>(),
                context.read<FontLoaderFactory>(),
              ),
            )
          ],
        );
}
