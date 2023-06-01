import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:self_hosted_fonts_helper/src/models/font_filter_item_model.dart';

import '../../../test_utils/read_model_fixture.dart';

void main() {
  late final String fixture;

  setUpAll(() async {
    fixture = await readModelFixture('font_filter_item');
  });

  group('.fromMap', () {
    test('given a map should create a FontFilterItemModel instance', () {
      final map = json.decode(fixture) as Map<String, dynamic>;

      final model = FontFilterItemModel.fromMap(map);

      expect(model, isA<FontFilterItemModel>());
    });
  });

  group('.fromJson', () {
    test(
      'given a json string should create a FontFilterItemModel instance',
      () {
        final model = FontFilterItemModel.fromJson(fixture);

        expect(model, isA<FontFilterItemModel>());
      },
    );
  });
}
