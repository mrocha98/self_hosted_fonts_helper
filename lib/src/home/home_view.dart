import 'package:flutter/material.dart';

import '../core/widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
