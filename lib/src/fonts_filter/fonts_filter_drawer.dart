import 'package:flutter/material.dart';

import '../core/locale/app_localizations.dart';

class FontsFilterDrawer extends StatelessWidget {
  const FontsFilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
            child: TextFormField(
              autofocus: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: AppLocalizations.of(context)!.fontsFilterLabelText,
                hintText:
                    AppLocalizations.of(context)!.fontsFilterHintText(2050),
                isDense: false,
                suffixIcon: PopupMenuButton<int>(
                  icon: const Icon(Icons.filter_alt_rounded),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      enabled: false,
                      child: Text(
                        AppLocalizations.of(context)!.fontsFilterOrderByLabel,
                      ),
                    ),
                    PopupMenuItem(
                      value: 0,
                      child: Text(
                        AppLocalizations.of(context)!
                            .fontsFilterOrderByFamilyParameter,
                      ),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        AppLocalizations.of(context)!
                            .fontsFilterOrderByCategoryParameter,
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        AppLocalizations.of(context)!
                            .fontsFilterOrderByPopularityParameter,
                      ),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text(
                        AppLocalizations.of(context)!
                            .fontsFilterOrderByLastModifiedParameter,
                      ),
                    ),
                    PopupMenuItem(
                      value: 4,
                      child: Text(
                        AppLocalizations.of(context)!
                            .fontsFilterOrderByNumberOfStylesParameter,
                      ),
                    ),
                    PopupMenuItem(
                      value: 5,
                      child: Text(
                        AppLocalizations.of(context)!
                            .fontsFilterOrderByNumberOfCharsetsParameter,
                      ),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem(
                      child: Row(
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
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text((index + 1).toString()),
                    subtitle: Text(((index + 1) * 10).toString()),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    selected: index == 0,
                    selectedTileColor:
                        Theme.of(context).colorScheme.inversePrimary,
                    selectedColor: Theme.of(context).listTileTheme.textColor,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
