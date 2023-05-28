import '../../models/font_filter_item_model.dart';
import '../../repositories/fonts/fonts_repository.dart';
import 'fonts_service.dart';

class FontsServiceImpl implements FontsService {
  FontsServiceImpl(this._fontsRepository);

  final FontsRepository _fontsRepository;

  @override
  Future<List<FontFilterItemModel>> getFilterFonts() =>
      _fontsRepository.getFilterFonts();
}
