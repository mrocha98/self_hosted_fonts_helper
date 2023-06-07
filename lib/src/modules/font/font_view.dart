import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_app_bar.dart';
import '../../models/font_model.dart';
import '../fonts_filter/fonts_filter_controller.dart';
import '../fonts_filter/fonts_filter_drawer.dart';
import '../home/home_view.dart';
import 'font_controller.dart';

class FontView extends StatefulWidget {
  const FontView({super.key});

  static const routeName = '/font';

  @override
  State<FontView> createState() => _FontViewState();
}

class _FontViewState extends State<FontView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final fontFilter = context.read<FontsFilterController>().selectedFont;
      if (fontFilter == null) {
        await Navigator.of(context).pushReplacementNamed(HomeView.routeName);
        return;
      }
      await context.read<FontController>().loadFont(
        fontFilter.id,
        [fontFilter.defaultSubset],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const FontsFilterDrawer(),
      body: Selector<FontController, FontModel?>(
        selector: (context, controller) => controller.font,
        builder: (context, font, _) {
          if (font == null) {
            return const Center(
              child: SizedBox.square(
                dimension: 64,
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  font.family,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontFamily: font.family,
                      ),
                ),
                Text(
                  font.category,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontFamily: font.family,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
