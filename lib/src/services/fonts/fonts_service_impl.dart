import '../../models/font_filter_item_model.dart';
import '../../models/font_model.dart';
import '../../models/font_variant_model.dart';
import '../../repositories/fonts/fonts_repository.dart';
import 'fonts_service.dart';

class FontsServiceImpl implements FontsService {
  FontsServiceImpl(this._fontsRepository);

  final FontsRepository _fontsRepository;

  @override
  Future<List<FontFilterItemModel>> getFilterFonts() =>
      _fontsRepository.getFilterFonts();

  @override
  Future<FontModel> getFont(String id, List<String> subsets) =>
      _fontsRepository.getFont(id, subsets);

  @override
  Future<List<int>> downloadFontVariant(FontVariantModel fontVariant) =>
      _fontsRepository.downloadFont(fontVariant.ttf, 'ttf');
}
