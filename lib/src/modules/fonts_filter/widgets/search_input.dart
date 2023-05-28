import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/locale/app_localizations.dart';
import '../../../models/font_filter_order_model.dart';
import '../fonts_filter_controller.dart';
import 'popup_menu_order.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final _searchEC = TextEditingController();

  @override
  void dispose() {
    _searchEC.dispose();
    super.dispose();
  }

  String _buildHintText(
    BuildContext context, {
    required int totalFonts,
    required FontFilterSortBy sortBy,
  }) {
    final sortByLocalizedMessage = switch (sortBy) {
      FontFilterSortBy.family =>
        AppLocalizations.of(context)!.fontsFilterOrderByFamilyParameter,
      FontFilterSortBy.category =>
        AppLocalizations.of(context)!.fontsFilterOrderByCategoryParameter,
      FontFilterSortBy.popularity =>
        AppLocalizations.of(context)!.fontsFilterOrderByPopularityParameter,
      FontFilterSortBy.lastModified =>
        AppLocalizations.of(context)!.fontsFilterOrderByLastModifiedParameter,
      FontFilterSortBy.numberOfStyles =>
        AppLocalizations.of(context)!.fontsFilterOrderByNumberOfStylesParameter,
      FontFilterSortBy.numberOfCharsets => AppLocalizations.of(context)!
          .fontsFilterOrderByNumberOfCharsetsParameter,
    };
    return AppLocalizations.of(context)!.fontsFilterHintText(
      totalFonts,
      sortByLocalizedMessage.toLowerCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchEC,
      autofocus: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: (query) {
        final controller = context.read<FontsFilterController>();
        if (query.isNotEmpty) {
          controller.search(query);
        } else {
          controller.resetFilteredList();
        }
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: AppLocalizations.of(context)!.fontsFilterLabelText,
        hintText: _buildHintText(
          context,
          totalFonts: context.select<FontsFilterController, int>(
            (controller) => controller.totalFonts,
          ),
          sortBy: context.select<FontsFilterController, FontFilterSortBy>(
            (controller) => controller.order.sortBy,
          ),
        ),
        isDense: false,
        suffixIcon: const PopupMenuOrder(),
      ),
    );
  }
}
