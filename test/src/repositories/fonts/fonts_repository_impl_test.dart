import 'dart:io';

import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:self_hosted_fonts_helper/src/core/exceptions/failure.dart';
import 'package:self_hosted_fonts_helper/src/core/exceptions/font_not_found_execption.dart';
import 'package:self_hosted_fonts_helper/src/core/http_client/http_client_response.dart';
import 'package:self_hosted_fonts_helper/src/repositories/fonts/fonts_repository_impl.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/fake_factories/fake_factories.dart';

void main() {
  late FontsRepositoryImpl sut;
  late HttpClientMock httpClientMock;
  late LoggerMock loggerMock;
  final faker = Faker.instance;

  setUp(() {
    httpClientMock = HttpClientMock();
    loggerMock = LoggerMock();
    sut = FontsRepositoryImpl(httpClientMock, loggerMock);
  });

  group('.getFilterFonts', () {
    test(
      'when request has success should parse response data and return it',
      () async {
        final model1 = FontFilterItemModelFakeFactory.make();
        final model2 = FontFilterItemModelFakeFactory.make();
        final respondeData = [model1.toMap(), model2.toMap()];
        when(() => httpClientMock.get<List<dynamic>>('/fonts')).thenAnswer(
          (_) async => HttpClientResponse(data: respondeData),
        );

        final filterFonts = await sut.getFilterFonts();

        expect(filterFonts, [model1, model2]);
      },
    );

    test('when request fails should throw a Failure', () {
      final exception = HttpClientExceptionMock();
      final exceptionMessage = faker.lorem.sentence();
      when(() => httpClientMock.get<List<dynamic>>('/fonts'))
          .thenThrow(exception);
      when(() => exception.message).thenReturn(exceptionMessage);
      when(() => loggerMock.error(exceptionMessage, exception))
          .thenAnswer((_) {});

      expect(
        () async => sut.getFilterFonts(),
        throwsA(
          isA<Failure>().having((f) => f.message, 'message', isNotEmpty),
        ),
      );
    });
  });

  group('.getFont', () {
    late String fontId;
    late List<String> subsets;

    setUp(() {
      fontId = faker.lorem.word();
      subsets = List.filled(
        faker.datatype.number(min: 1, max: 5),
        faker.lorem.word(),
      );
    });

    test('when request has success should return a FontModel', () async {
      final expectedModel = FontModelFakeFactory.make();
      final subsetsJoined = subsets.join(',');
      when(
        () => httpClientMock.get<Map<String, dynamic>>(
          '/fonts/$fontId',
          queryParameters: {'subsets': subsetsJoined},
        ),
      ).thenAnswer(
        (_) async => HttpClientResponse(data: expectedModel.toMap()),
      );

      final model = await sut.getFont(fontId, subsets);

      expect(model, expectedModel);
    });

    test(
      'when catch a HttpClientException with code Not-Found should throw a '
      'FontNotFoundException',
      () {
        final exception = HttpClientExceptionMock();
        when(() => exception.statusCode).thenReturn(HttpStatus.notFound);
        when(
          () => httpClientMock.get<Map<String, dynamic>>(
            '/fonts/$fontId',
            queryParameters: {'subsets': subsets.join(',')},
          ),
        ).thenThrow(exception);

        expect(
          () async => sut.getFont(fontId, subsets),
          throwsA(isA<FontNotFoundExecption>()),
        );
      },
    );

    test(
      'when catch a HttpClientException with a code that is not Not-Found '
      'should throw a Failure',
      () {
        final exception = HttpClientExceptionMock();
        when(() => exception.statusCode).thenReturn(HttpStatus.badRequest);
        when(
          () => httpClientMock.get<Map<String, dynamic>>(
            '/fonts/$fontId',
            queryParameters: {'subsets': subsets.join(',')},
          ),
        ).thenThrow(exception);

        expect(
          () async => sut.getFont(fontId, subsets),
          throwsA(
            isA<Failure>().having((f) => f.message, 'message', isNotEmpty),
          ),
        );
      },
    );
  });
}
