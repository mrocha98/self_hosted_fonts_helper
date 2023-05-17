import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  const LinkText(
    this.data, {
    required this.href,
    this.style,
    super.key,
  });

  final String data;

  final Uri href;

  final TextStyle? style;

  Future<void> _handleTap() async {
    await launchUrl(href);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
      child: Text(
        data,
        style: (style ?? const TextStyle()).copyWith(
          color: Theme.of(context).colorScheme.tertiary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
