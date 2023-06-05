import 'package:faker_dart/faker_dart.dart';
import 'package:self_hosted_fonts_helper/src/models/font_model.dart';

import 'font_variant_model_fake_factory.dart';

class FontModelFakeFactory {
  FontModelFakeFactory._internal();

  static final Faker _faker = Faker.instance;

  static FontModel make() => FontModel(
        id: _faker.datatype.uuid(),
        family: _faker.lorem.word(),
        subsets: List.filled(
          _faker.datatype.number(min: 1, max: 5),
          _faker.lorem.word(),
        ),
        category: _faker.lorem.word(),
        version: 'v${_faker.datatype.number()}',
        lastModified: _faker.datatype.dateTime().toIso8601String(),
        popularity: _faker.datatype.number(),
        defaultSubset: _faker.lorem.word(),
        defaultVariant: _faker.lorem.word(),
        subsetMap: Map.fromIterables([
          _faker.lorem.word(),
          _faker.lorem.word(),
          _faker.lorem.word(),
        ], [
          _faker.datatype.boolean(),
          _faker.datatype.boolean(),
          _faker.datatype.boolean(),
        ]),
        storeId: _faker.datatype.uuid(),
        variants: FontVariantModelFakeFactory.makeList(),
      );

  static List<FontModel> makeList({int length = 2}) =>
      List.filled(length, make());
}
