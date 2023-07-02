import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/ui/extensions/size_extensions.dart';
import '../../core/widgets/generic_error_message.dart';
import '../../core/widgets/shimmer_container.dart';
import 'fonts_filter_controller.dart';
import 'widgets/fonts_list.dart';
import 'widgets/search_input.dart';

class FontsFilterDrawer extends StatefulWidget {
  const FontsFilterDrawer({super.key});

  @override
  State<FontsFilterDrawer> createState() => _FontsFilterDrawerState();
}

class _FontsFilterDrawerState extends State<FontsFilterDrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final controller = context.read<FontsFilterController>();
      if (controller.filteredFonts.isEmpty) {
        await controller.loadFonts();
      }
    });
  }

  Widget _buildLoadingShimmer() {
    final itemCount = context.screenHeight ~/ 100;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: ListView.separated(
        itemBuilder: (context, _) => ShimmerContainer(
          child: Container(
            width: double.infinity,
            height: 96,
            color: Colors.white,
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildContent(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: const Border(
                bottom: BorderSide(),
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: const SearchInput(),
          ),
          const Expanded(
            child: FontsList(),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Selector<FontsFilterController, bool>(
        selector: (context, controller) => controller.loading,
        builder: (context, loading, _) => Visibility(
          visible: !loading,
          replacement: _buildLoadingShimmer(),
          child: Selector<FontsFilterController, bool>(
            selector: (context, controller) => controller.error,
            builder: (context, hasError, _) {
              if (hasError) {
                return const GenericErrorMessage();
              }
              return _buildContent(context);
            },
          ),
        ),
      ),
    );
  }
}
