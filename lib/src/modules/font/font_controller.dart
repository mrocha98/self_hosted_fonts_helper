import 'package:flutter/material.dart';

class FontController extends ChangeNotifier {
  Future<void> loadFont(String fontId, List<String> charsets) async {
    assert(charsets.isNotEmpty, 'charsets must not be empty');
    print('loading font $fontId');
  }
}
