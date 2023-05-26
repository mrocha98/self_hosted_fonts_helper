import 'package:provider/provider.dart';

import '../../core/http_client/http_client.dart';
import '../../core/logger/logger.dart';
import '../../core/module/module.dart';
import '../../repositories/fonts/fonts_repository.dart';
import '../../repositories/fonts/fonts_repository_impl.dart';

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
          ],
        );
}
