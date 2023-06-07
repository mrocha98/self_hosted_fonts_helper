import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/font_loader/font_loader_factory_type.dart';
import '../../models/font_model.dart';
import '../../services/fonts/fonts_service.dart';

class FontController extends ChangeNotifier {
  FontController(this._fontsService, this._fontLoaderFactory);

  final FontsService _fontsService;

  final FontLoaderFactory _fontLoaderFactory;

  FontModel? _font;

  FontModel? get font => _font;

  Future<void> loadFont(String fontId, List<String> charsets) async {
    assert(charsets.isNotEmpty, 'charsets must not be empty');

    final font = await _fontsService.getFont(fontId, charsets);
    _font = font;

    final variantsBytes = font.variants.map((variant) async {
      final bin = await _fontsService.downloadFontVariant(variant);
      final buffer = Uint8List.fromList(bin).buffer;
      return ByteData.view(buffer);
    });
    final loader = _fontLoaderFactory(font.family);
    variantsBytes.forEach(loader.addFont);
    await loader.load();

    notifyListeners();
  }
}
