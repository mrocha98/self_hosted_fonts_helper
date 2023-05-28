import 'package:faker_dart/faker_dart.dart';
import 'package:self_hosted_fonts_helper/src/models/font_filter_item_model.dart';

class FontFilterItemModelFakeFactory {
  FontFilterItemModelFakeFactory._internal();

  static final Faker _faker = Faker.instance;

  static FontFilterItemModel make() => FontFilterItemModel(
        id: _faker.datatype.uuid(),
        family: _faker.lorem.word(),
        variants: List.filled(
          _faker.datatype.number(max: 5),
          _faker.lorem.word(),
        ),
        subsets: List.filled(
          _faker.datatype.number(max: 5),
          _faker.lorem.word(),
        ),
        category: _faker.lorem.word(),
        version: 'v${_faker.datatype.number()}',
        lastModified: _faker.datatype.dateTime().toIso8601String(),
        popularity: _faker.datatype.number(),
        defaultSubset: _faker.lorem.word(),
        defaultVariant: _faker.lorem.word(),
      );

  static List<FontFilterItemModel> makeList({int length = 2}) =>
      List.filled(length, make());
}
