import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/widgets/custom_app_bar.dart';
import '../../core/widgets/generic_error_message.dart';
import '../../models/font_model.dart';
import '../fonts_filter/fonts_filter_controller.dart';
import '../fonts_filter/fonts_filter_drawer.dart';
import '../home/home_view.dart';
import 'font_controller.dart';
import 'widgets/font_view_header.dart';
import 'widgets/font_view_loading_shimmer.dart';

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
    scheduleMicrotask(_loadFont);
  }

  Future<void> _loadFont() async {
    final fontFilter = context.read<FontsFilterController>().selectedFont;
    if (fontFilter == null) {
      await Navigator.of(context).pushReplacementNamed(HomeView.routeName);
      return;
    }
    await context.read<FontController>().loadFont(
      fontFilter.id,
      [fontFilter.defaultSubset],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const FontsFilterDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Visibility(
          visible: context.select<FontController, bool>(
            (controller) => !controller.error,
          ),
          replacement: GenericErrorMessage(retry: _loadFont),
          child: Selector<FontController, FontModel?>(
            selector: (context, controller) => controller.font,
            builder: (context, font, _) {
              if (font == null) {
                return const FontViewLoadingShimmer();
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FontViewHeader(font: font),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
