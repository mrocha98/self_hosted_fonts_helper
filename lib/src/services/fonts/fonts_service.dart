import '../../models/font_filter_item_model.dart';
import '../../models/font_model.dart';
import '../../models/font_variant_model.dart';

abstract interface class FontsService {
  Future<List<FontFilterItemModel>> getFilterFonts();
  Future<FontModel> getFont(String id, List<String> subsets);
  Future<List<int>> downloadFontVariant(FontVariantModel fontVariant);
}
