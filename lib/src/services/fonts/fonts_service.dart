import '../../models/font_filter_item_model.dart';

abstract interface class FontsService {
  Future<List<FontFilterItemModel>> getFilterFonts();
}
