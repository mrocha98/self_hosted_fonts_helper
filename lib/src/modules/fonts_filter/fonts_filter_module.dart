import 'package:provider/provider.dart';

import '../../core/http_client/http_client.dart';
import '../../core/logger/logger.dart';
import '../../core/module/module.dart';
import '../../repositories/fonts/fonts_repository.dart';
import '../../repositories/fonts/fonts_repository_impl.dart';
import '../../services/fonts/fonts_service.dart';
import '../../services/fonts/fonts_service_impl.dart';
import 'fonts_filter_controller.dart';

class FontsFilterModule extends Module {
  FontsFilterModule()
      : super(
          routes: {},
          bindings: [
            Provider<FontsRepository>(
              create: (context) => FontsRepositoryImpl(
                context.read<HttpClient>(),
                context.read<Logger>(),
              ),
            ),
            Provider<FontsService>(
              create: (context) => FontsServiceImpl(
                context.read<FontsRepository>(),
              ),
            ),
            ChangeNotifierProvider<FontsFilterController>(
              create: (context) => FontsFilterController(
                context.read<FontsService>(),
              ),
            ),
          ],
        );
}
