import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:self_hosted_fonts_helper/src/models/font_variant_model.dart';

import '../../../test_utils/read_model_fixture.dart';

void main() {
  late final String fixture;

  setUpAll(() async {
    fixture = await readModelFixture('font_variant');
  });

  group('.fromMap', () {
    test('given a map should create a FontVariantModel instance', () {
      final map = json.decode(fixture) as Map<String, dynamic>;

      final model = FontVariantModel.fromMap(map);

      expect(model, isA<FontVariantModel>());
    });
  });

  group('.fromJson', () {
    test('given a json string should create a FontVariantModel instance', () {
      final model = FontVariantModel.fromJson(fixture);

      expect(model, isA<FontVariantModel>());
    });
  });
}
