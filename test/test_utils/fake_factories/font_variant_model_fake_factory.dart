import 'package:faker_dart/faker_dart.dart';
import 'package:self_hosted_fonts_helper/src/models/font_variant_model.dart';

class FontVariantModelFakeFactory {
  FontVariantModelFakeFactory._internal();

  static final Faker _faker = Faker.instance;

  static FontVariantModel make() => FontVariantModel(
        id: _faker.datatype.uuid(),
        fontFamily: _faker.lorem.word(),
        fontStyle: _faker.lorem.word(),
        fontWeight: _faker.datatype.number().toString(),
        woff: _faker.internet.url(),
        woff2: _faker.internet.url(),
        eot: _faker.internet.url(),
        svg: _faker.internet.url(),
        ttf: _faker.internet.url(),
      );

  static List<FontVariantModel> makeList({int length = 2}) =>
      List.filled(length, make());
}
