import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui/icons/github_icon.dart';

class GithubRepositoryButton extends StatelessWidget {
  const GithubRepositoryButton({super.key});

  Uri get _repositoryUrl =>
      Uri.https('github.com', '/mrocha98/self_hosted_fonts_helper');

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await launchUrl(_repositoryUrl);
      },
      icon: const Icon(GithubIcon.github),
    );
  }
}
