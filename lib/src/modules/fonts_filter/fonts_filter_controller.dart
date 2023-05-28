import 'package:flutter/material.dart';

import '../../core/exceptions/failure.dart';
import '../../models/font_filter_item_model.dart';
import '../../models/font_filter_order_model.dart';
import '../../services/fonts/fonts_service.dart';

class FontsFilterController extends ChangeNotifier {
  FontsFilterController(this._fontsService);

  final FontsService _fontsService;

  bool error = false;

  bool loading = false;

  FontFilterItemModel? selectedFont;

  FontFilterOrderModel _order = const FontFilterOrderModel(
    sortBy: FontFilterSortBy.popularity,
    order: FontFilterOrder.descending,
  );

  FontFilterOrderModel get order => _order;

  List<FontFilterItemModel> _fonts = const [];

  List<FontFilterItemModel> _filteredFonts = const [];

  List<FontFilterItemModel> get filteredFonts => _filteredFonts;

  int get totalFonts => _fonts.length;

  Future<void> loadFonts() async {
    loading = true;
    error = false;
    notifyListeners();

    try {
      final fonts = await _fontsService.getFilterFonts();
      _fonts = fonts.toList(growable: false);
      _filteredFonts = fonts.toList(growable: false);
      sortFilteredList();
    } on Failure catch (_) {
      error = true;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setSortBy(FontFilterSortBy sortBy) {
    _order = order.copyWith(sortBy: sortBy);
    sortFilteredList();
  }

  void setOrder(FontFilterOrder order) {
    _order = this.order.copyWith(order: order);
    sortFilteredList();
  }

  int _sortByFamilyCompare(FontFilterItemModel a, FontFilterItemModel b) =>
      _order.order == FontFilterOrder.descending
          ? a.family.compareTo(b.family)
          : b.family.compareTo(a.family);

  int _sortByCategoryCompare(FontFilterItemModel a, FontFilterItemModel b) =>
      _order.order == FontFilterOrder.descending
          ? a.category.compareTo(b.category)
          : b.category.compareTo(a.category);

  int _sortByPopularityCompare(FontFilterItemModel a, FontFilterItemModel b) =>
      _order.order == FontFilterOrder.descending
          ? a.popularity.compareTo(b.popularity)
          : b.popularity.compareTo(a.popularity);

  int _sortByLastModifiedCompare(
    FontFilterItemModel a,
    FontFilterItemModel b,
  ) =>
      _order.order == FontFilterOrder.descending
          ? DateTime.parse(a.lastModified)
              .compareTo(DateTime.parse(b.lastModified))
          : DateTime.parse(b.lastModified)
              .compareTo(DateTime.parse(a.lastModified));

  int _sortByNumberOfStylesCompare(
    FontFilterItemModel a,
    FontFilterItemModel b,
  ) =>
      _order.order == FontFilterOrder.descending
          ? a.variants.length.compareTo(b.variants.length)
          : b.variants.length.compareTo(a.variants.length);

  int _sortByNumberOfCharsetsCompare(
    FontFilterItemModel a,
    FontFilterItemModel b,
  ) =>
      _order.order == FontFilterOrder.descending
          ? a.subsets.length.compareTo(b.subsets.length)
          : b.subsets.length.compareTo(a.subsets.length);

  void sortFilteredList() {
    _filteredFonts.sort(
      switch (_order.sortBy) {
        FontFilterSortBy.family => _sortByFamilyCompare,
        FontFilterSortBy.category => _sortByCategoryCompare,
        FontFilterSortBy.popularity => _sortByPopularityCompare,
        FontFilterSortBy.lastModified => _sortByLastModifiedCompare,
        FontFilterSortBy.numberOfStyles => _sortByNumberOfStylesCompare,
        FontFilterSortBy.numberOfCharsets => _sortByNumberOfCharsetsCompare,
      },
    );
    notifyListeners();
  }

  void search(String query) {
    _filteredFonts = _fonts
        .where(
          (font) => font.family.toLowerCase().contains(query.toLowerCase()),
        )
        .toList(growable: false);
    notifyListeners();
  }

  void resetFilteredList() {
    _filteredFonts = _fonts.toList(growable: false);
    notifyListeners();
  }
}
