import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:self_hosted_fonts_helper/src/models/font_model.dart';

import '../../../test_utils/read_model_fixture.dart';

void main() {
  late final String fixture;

  setUpAll(() async {
    fixture = await readModelFixture('font_model');
  });

  group('.fromMap', () {
    test('given a map should create a FontModel instance', () {
      final map = json.decode(fixture) as Map<String, dynamic>;

      final model = FontModel.fromMap(map);

      expect(model, isA<FontModel>());
    });
  });

  group('.fromJson', () {
    test('given a json string should create a FontModel instance', () {
      final model = FontModel.fromJson(fixture);

      expect(model, isA<FontModel>());
    });
  });
}
