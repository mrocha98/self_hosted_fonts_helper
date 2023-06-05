import '../../models/font_filter_item_model.dart';
import '../../models/font_model.dart';

abstract interface class FontsRepository {
  Future<List<FontFilterItemModel>> getFilterFonts();
  Future<FontModel> getFont(String id, List<String> subsets);
  Future<List<int>> downloadFont(String url, String extension);
}
