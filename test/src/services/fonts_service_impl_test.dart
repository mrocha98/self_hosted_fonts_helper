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
}
