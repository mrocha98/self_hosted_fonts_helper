import 'package:flutter/material.dart';

import '../core/locale/app_localizations.dart';
import '../core/widgets/custom_app_bar.dart';
import '../core/widgets/link_text.dart';
import '../core/widgets/text_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.appTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Text(
                  AppLocalizations.of(context)!.appSubtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              LinkText(
                AppLocalizations.of(context)!.homeAuthorLink,
                href: Uri.https('github.com', '/mrocha98'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                ),
                child: Divider(),
              ),
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_rounded,
                    size: Theme.of(context).textTheme.bodySmall!.fontSize,
                  ),
                  const SizedBox(width: 4),
                  Text(AppLocalizations.of(context)!.homeContinueAction),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: Text(
                  AppLocalizations.of(context)!.homeUsefulLinksSectionTitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextList(
                childen: [
                  LinkText(
                    AppLocalizations.of(context)!
                        .homeUsefulLinkGoogleFontsOpenSourceFontAttribution,
                    href: Uri.https('fonts.google.com', '/attribution'),
                  ),
                  LinkText(
                    AppLocalizations.of(context)!
                        .homeUsefulLinkSelfHostingGoogleFonts,
                    href: Uri.https(
                      'mranftl.com',
                      '/2014/12/23/self-hosting-google-web-fonts/',
                    ),
                  ),
                  LinkText(
                    AppLocalizations.of(context)!.homeUsefulLinkCanIUseWoff2,
                    href: Uri.https('caniuse.com', '/woff2'),
                  ),
                  LinkText(
                    AppLocalizations.of(context)!
                        .homeUsefulLinkHowToUseFontFaceInCss,
                    href: Uri.https(
                      'css-tricks.com',
                      '/snippets/css/using-font-face-in-css/',
                    ),
                  ),
                  LinkText(
                    AppLocalizations.of(context)!.homeUsefulFontsSetupInFlutter,
                    href: Uri.https(
                      'docs.flutter.dev',
                      '/cookbook/design/fonts',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
