import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/exceptions/failure.dart';
import '../../core/font_loader/font_loader_factory_type.dart';
import '../../models/font_extensions_category_model.dart';
import '../../models/font_model.dart';
import '../../services/fonts/fonts_service.dart';

class FontController extends ChangeNotifier {
  FontController(this._fontsService, this._fontLoaderFactory);

  final FontsService _fontsService;

  final FontLoaderFactory _fontLoaderFactory;

  FontModel? _font;

  FontModel? get font => _font;

  bool _error = false;

  bool get error => _error;

  List<String> selectedSubsets = [];

  List<String> selectedVariants = [];

  FontExtensionsCategory selectedFontExtensionsCategory =
      FontExtensionsCategory.modernWeb;

  Future<void> loadFont(String fontId, [List<String>? subsets]) async {
    _error = false;
    _font = null;
    notifyListeners();

    try {
      final font = await _fontsService.getFont(
        fontId,
        subsets ?? selectedSubsets,
      );
      _font = font;

      final variantsBytes = font.variants.map((variant) async {
        final bin = await _fontsService.downloadFontVariant(variant);
        final buffer = Uint8List.fromList(bin).buffer;
        return ByteData.view(buffer);
      });
      final loader = _fontLoaderFactory(font.family);
      variantsBytes.forEach(loader.addFont);
      await loader.load();
    } on Failure catch (_) {
      _error = true;
    } finally {
      notifyListeners();
    }
  }
}
