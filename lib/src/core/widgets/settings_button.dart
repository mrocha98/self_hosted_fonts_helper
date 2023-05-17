import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import '../../settings/settings_module.dart';
import '../../settings/settings_view.dart';
import '../ui/extensions/size_extensions.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  void _showSettingsPopover(BuildContext context) {
    showPopover(
      context: context,
      bodyBuilder: (context) => SettingsModule().getView(
        context,
        routeName: SettingsView.routeName,
      ),
      direction: PopoverDirection.top,
      constraints: BoxConstraints.loose(
        Size(
          context.percentWidth(.3),
          context.percentHeight(.6),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      arrowHeight: 0,
      arrowWidth: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showSettingsPopover(context),
      icon: const Icon(Icons.settings),
    );
  }
}
