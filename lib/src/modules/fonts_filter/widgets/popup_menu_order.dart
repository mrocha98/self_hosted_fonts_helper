import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/locale/app_localizations.dart';
import '../../../models/font_filter_order_model.dart';
import '../fonts_filter_controller.dart';

class PopupMenuOrder extends StatelessWidget {
  const PopupMenuOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FontsFilterController>(
      builder: (context, controller, _) => PopupMenuButton<dynamic>(
        icon: const Icon(Icons.filter_alt_rounded),
        onSelected: (value) {
          switch (value.runtimeType) {
            case FontFilterOrder:
              controller.setOrder(value as FontFilterOrder);
            case FontFilterSortBy:
              controller.setSortBy(value as FontFilterSortBy);
          }
        },
        initialValue: controller.order.sortBy,
        itemBuilder: (context) => [
          PopupMenuItem(
            enabled: false,
            child: Text(
              AppLocalizations.of(context)!.fontsFilterOrderByLabel,
            ),
          ),
          PopupMenuItem(
            value: FontFilterSortBy.family,
            child: Text(
              AppLocalizations.of(context)!.fontsFilterOrderByFamilyParameter,
            ),
          ),
          PopupMenuItem(
            value: FontFilterSortBy.category,
            child: Text(
              AppLocalizations.of(context)!.fontsFilterOrderByCategoryParameter,
            ),
          ),
          PopupMenuItem(
            value: FontFilterSortBy.popularity,
            child: Text(
              AppLocalizations.of(context)!
                  .fontsFilterOrderByPopularityParameter,
            ),
          ),
          PopupMenuItem(
            value: FontFilterSortBy.lastModified,
            child: Text(
              AppLocalizations.of(context)!
                  .fontsFilterOrderByLastModifiedParameter,
            ),
          ),
          PopupMenuItem(
            value: FontFilterSortBy.numberOfStyles,
            child: Text(
              AppLocalizations.of(context)!
                  .fontsFilterOrderByNumberOfStylesParameter,
            ),
          ),
          PopupMenuItem(
            value: FontFilterSortBy.numberOfCharsets,
            child: Text(
              AppLocalizations.of(context)!
                  .fontsFilterOrderByNumberOfCharsetsParameter,
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            value: controller.order.order == FontFilterOrder.ascending
                ? FontFilterOrder.descending
                : FontFilterOrder.ascending,
            child: Visibility(
              visible: controller.order.order == FontFilterOrder.ascending,
              replacement: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_downward_rounded),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations.of(context)!
                        .fontsFilterSortOrderDescending,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_upward_rounded),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations.of(context)!.fontsFilterSortOrderAscending,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
