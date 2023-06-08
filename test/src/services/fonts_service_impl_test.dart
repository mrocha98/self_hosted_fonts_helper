import 'package:clock/clock.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:self_hosted_fonts_helper/src/services/fonts/fonts_service_impl.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/fake_factories/fake_factories.dart';

void main() {
  late FontsServiceImpl sut;
  late FontsRepositoryMock fontsRepositoryMock;
  late KeyValueStorageMock keyValueStorageMock;
  final faker = Faker.instance;

  setUp(() {
    fontsRepositoryMock = FontsRepositoryMock();
    keyValueStorageMock = KeyValueStorageMock();
    sut = FontsServiceImpl(fontsRepositoryMock, keyValueStorageMock);
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
    late DateTime now;

    setUp(() {
      now = faker.datatype.dateTime();
    });

    test('when have ttf binary in cache should return it', () {
      withClock(Clock.fixed(now), () async {
        final cache = [1, 0, 1, 0, 1, 0, 1];
        final fontVariant = FontVariantModelFakeFactory.make();
        when(() => keyValueStorageMock.getList<int>(fontVariant.ttf))
            .thenAnswer((_) async => cache);

        final bin = await sut.downloadFontVariant(fontVariant);

        expect(bin, cache);
        verifyZeroInteractions(fontsRepositoryMock);
      });
    });

    test(
        'when dont have ttf binary in cache should get it font from '
        'FontsRepositoryMock and store in cache with 1 week expiration', () {
      withClock(Clock.fixed(now), () async {
        final repoBin = [1, 0, 1, 0, 1, 0, 1];
        final fontVariant = FontVariantModelFakeFactory.make();
        final expiration = now.add(const Duration(days: 7));
        when(() => keyValueStorageMock.getList<int>(fontVariant.ttf))
            .thenAnswer((_) async => null);
        when(
          () => keyValueStorageMock.set<List<int>>(
            fontVariant.ttf,
            repoBin,
            expiresOn: expiration,
          ),
        ).thenAnswer((_) async {});
        when(() => fontsRepositoryMock.downloadFont(fontVariant.ttf, 'ttf'))
            .thenAnswer((_) async => repoBin);

        final bin = await sut.downloadFontVariant(fontVariant);

        expect(bin, repoBin);
        verify(() => fontsRepositoryMock.downloadFont(fontVariant.ttf, 'ttf'))
            .called(1);
        verify(
          () => keyValueStorageMock.set<List<int>>(
            fontVariant.ttf,
            repoBin,
            expiresOn: expiration,
          ),
        ).called(1);
      });
    });
  });
}
