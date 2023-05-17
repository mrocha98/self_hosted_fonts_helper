import 'package:flutter/material.dart';

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
      actions: const [
        GithubRepositoryButton(),
        SizedBox(width: 8),
        SettingsButton(),
      ],
    );
  }
}
