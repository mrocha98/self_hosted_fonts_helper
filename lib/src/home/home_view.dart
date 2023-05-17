import 'package:flutter/material.dart';

import '../core/widgets/settings_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('HOME'),
        actions: const [
          SettingsButton(),
        ],
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
