import 'package:clock/clock.dart';

import '../../core/database/key_value_storage/key_value_storage.dart';
import '../../models/font_filter_item_model.dart';
import '../../models/font_model.dart';
import '../../models/font_variant_model.dart';
import '../../repositories/fonts/fonts_repository.dart';
import 'fonts_service.dart';

class FontsServiceImpl implements FontsService {
  FontsServiceImpl(this._fontsRepository, this._kv);

  final FontsRepository _fontsRepository;

  final KeyValueStorage _kv;

  @override
  Future<List<FontFilterItemModel>> getFilterFonts() =>
      _fontsRepository.getFilterFonts();

  @override
  Future<FontModel> getFont(String id, List<String> subsets) =>
      _fontsRepository.getFont(id, subsets);

  @override
  Future<List<int>> downloadFontVariant(FontVariantModel fontVariant) async {
    final binaryInCache = await _kv.getList<int>(fontVariant.ttf);
    if (binaryInCache != null) {
      return binaryInCache;
    }
    final binary = await _fontsRepository.downloadFont(fontVariant.ttf, 'ttf');
    final expirationDate = clock.now().add(const Duration(days: 7));
    await _kv.set<List<int>>(
      fontVariant.ttf,
      binary,
      expiresOn: expirationDate,
    );
    return binary;
  }
}
