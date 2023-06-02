import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/font_filter_item_model.dart';
import '../../../models/font_filter_order_model.dart';
import '../../font/font_view.dart';
import '../fonts_filter_controller.dart';

class FontsList extends StatelessWidget {
  const FontsList({super.key});

  String _parseSubtitle(
    BuildContext content,
    FontFilterItemModel font,
    FontFilterSortBy sortBy,
  ) =>
      switch (sortBy) {
        FontFilterSortBy.family => font.category,
        FontFilterSortBy.category => font.category,
        FontFilterSortBy.popularity => '${font.popularity}°',
        FontFilterSortBy.lastModified => font.lastModified,
        FontFilterSortBy.numberOfStyles => '${font.variants.length} styles',
        FontFilterSortBy.numberOfCharsets => '${font.subsets.length} charsets',
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Consumer<FontsFilterController>(
        builder: (context, controller, _) => ListView.separated(
          itemBuilder: (context, index) => Builder(
            builder: (context) {
              final font = controller.filteredFonts[index];
              final selected = font == controller.selectedFont;
              final sortBy = controller.order.sortBy;
              return ListTile(
                key: Key(font.id),
                title: Text(font.family),
                subtitle: Text(_parseSubtitle(context, font, sortBy)),
                onTap: () {
                  context.read<FontsFilterController>()
                    ..selectedFont = font
                    ..resetFilteredList();
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushNamed(FontView.routeName, arguments: font);
                },
                selected: selected,
                selectedTileColor: Theme.of(context).colorScheme.inversePrimary,
                selectedColor: Theme.of(context).listTileTheme.textColor,
              );
            },
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: controller.filteredFonts.length,
        ),
      ),
    );
  }
}
