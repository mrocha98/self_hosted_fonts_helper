import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:self_hosted_fonts_helper/src/services/fonts/fonts_service_impl.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/fake_factories/fake_factories.dart';

void main() {
  late FontsServiceImpl sut;
  late FontsRepositoryMock fontsRepositoryMock;

  setUp(() {
    fontsRepositoryMock = FontsRepositoryMock();
    sut = FontsServiceImpl(fontsRepositoryMock);
  });

  group('.getFilterFonts', () {
    test('should get the list from FontsRepositoryMock', () async {
      final repoList = FontFilterItemModelFakeFactory.makeList();
      when(() => fontsRepositoryMock.getFilterFonts())
          .thenAnswer((_) async => repoList);

      final list = await sut.getFilterFonts();

      expect(list, repoList);
      verify(() => fontsRepositoryMock.getFilterFonts()).called(1);
    });
  });

  group('.getFont', () {
    test('should get the font from FontsRepositoryMock', () async {
      final repoFont = FontModelFakeFactory.make();
      when(() => fontsRepositoryMock.getFont(repoFont.id, repoFont.subsets))
          .thenAnswer((_) async => repoFont);

      final font = await sut.getFont(repoFont.id, repoFont.subsets);

      expect(font, repoFont);
      verify(() => fontsRepositoryMock.getFont(repoFont.id, repoFont.subsets))
          .called(1);
    });
  });

  group('.downloadFontVariant', () {
    test('should get binary of ttf font from FontsRepositoryMock', () async {
      final repoBin = [1, 0, 1, 0, 1, 0, 1];
      final fontVariant = FontVariantModelFakeFactory.make();
      when(() => fontsRepositoryMock.downloadFont(fontVariant.ttf, 'ttf'))
          .thenAnswer((_) async => repoBin);

      final bin = await sut.downloadFontVariant(fontVariant);

      expect(bin, repoBin);
      verify(() => fontsRepositoryMock.downloadFont(fontVariant.ttf, 'ttf'))
          .called(1);
    });
  });
}
