import '../../models/font_filter_item_model.dart';

abstract interface class FontsRepository {
  Future<List<FontFilterItemModel>> getFilterFonts();
}
