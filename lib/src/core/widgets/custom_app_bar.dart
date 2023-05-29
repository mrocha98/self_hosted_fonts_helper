import 'package:flutter/material.dart';

import '../../modules/home/home_view.dart';
import '../locale/app_localizations.dart';
import 'github_repository_button.dart';
import 'settings_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(AppLocalizations.of(context)!.appTitle),
      centerTitle: true,
      actions: [
        if (ModalRoute.of(context)!.settings.name != HomeView.routeName)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(HomeView.routeName),
              icon: const Icon(Icons.home),
            ),
          ),
        const GithubRepositoryButton(),
        const SizedBox(width: 8),
        const SettingsButton(),
      ],
    );
  }
}
