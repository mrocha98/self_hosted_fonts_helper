import '../../core/module/module.dart';
import 'home_view.dart';

class HomeModule extends Module {
  HomeModule()
      : super(
          routes: {
            HomeView.routeName: (context) => const HomeView(),
          },
        );
}
