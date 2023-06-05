import 'dart:io';

import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:self_hosted_fonts_helper/src/core/exceptions/failure.dart';
import 'package:self_hosted_fonts_helper/src/core/exceptions/font_not_found_execption.dart';
import 'package:self_hosted_fonts_helper/src/core/http_client/http_client_response.dart';
import 'package:self_hosted_fonts_helper/src/core/http_client/http_client_response_type.dart';
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

    test('when request fails should log', () async {
      when(() => httpClientMock.get<List<dynamic>>('/fonts'))
          .thenThrow(HttpClientExceptionMock());

      await sut.getFilterFonts().onError<Failure>((_, __) => []).whenComplete(
            () => verify(
              () => loggerMock.error(any<String>(), any<dynamic>(), any()),
            ).called(1),
          );

      verifyNoMoreInteractions(loggerMock);
    });
  });

  group('.getFont', () {
    late String fontId;
    late List<String> subsets;
    late String subsetsJoined;

    setUp(() {
      fontId = faker.lorem.word();
      subsets = List.filled(
        faker.datatype.number(min: 1, max: 5),
        faker.lorem.word(),
      );
      subsetsJoined = subsets.join(',');
    });

    test('when request has success should return a FontModel', () async {
      final expectedModel = FontModelFakeFactory.make();
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
            queryParameters: {'subsets': subsetsJoined},
          ),
        ).thenThrow(exception);

        expect(
          () async => sut.getFont(fontId, subsets),
          throwsA(isA<FontNotFoundExecption>()),
        );
      },
    );

    test(
      'when catch a HttpClientException with code Not-Found should log',
      () async {
        final exception = HttpClientExceptionMock();
        when(
          () => httpClientMock.get<Map<String, dynamic>>(
            '/fonts/$fontId',
            queryParameters: {'subsets': subsetsJoined},
          ),
        ).thenThrow(exception);
        when(() => exception.statusCode).thenReturn(HttpStatus.notFound);

        await sut
            .getFont(fontId, subsets)
            .onError<FontNotFoundExecption>(
              (_, __) => FontModelFakeFactory.make(),
            )
            .whenComplete(
              () => verify(
                () => loggerMock.error(any<String>(), any<dynamic>(), any()),
              ).called(1),
            );
        verifyNoMoreInteractions(loggerMock);
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
            queryParameters: {'subsets': subsetsJoined},
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

    test(
      'when catch a HttpClientException with a code that is not Not-Found '
      'should log',
      () async {
        final exception = HttpClientExceptionMock();
        when(
          () => httpClientMock.get<Map<String, dynamic>>(
            '/fonts/$fontId',
            queryParameters: {'subsets': subsetsJoined},
          ),
        ).thenThrow(exception);
        when(() => exception.statusCode).thenReturn(HttpStatus.badGateway);

        await sut
            .getFont(fontId, subsets)
            .onError<Failure>(
              (_, __) => FontModelFakeFactory.make(),
            )
            .whenComplete(
              () => verify(
                () => loggerMock.error(any<String>(), any<dynamic>(), any()),
              ).called(1),
            );
        verifyNoMoreInteractions(loggerMock);
      },
    );
  });

  group('.downloadFont', () {
    const extension = 'ttf';
    late String url;

    setUp(() {
      url = faker.internet.url();
    });

    test('when request has success should return a binary list', () async {
      final expected = [1, 0, 1, 1, 1, 0, 1];
      when(
        () => httpClientMock.get<List<int>>(
          url,
          useBaseUrl: false,
          contentType: 'font/$extension',
          responseType: HttpClientResponseType.bytes,
        ),
      ).thenAnswer((_) async => HttpClientResponse(data: expected));

      final bytes = await sut.downloadFont(url, extension);

      expect(bytes, expected);
    });

    test('when request fails should throw a Failure', () {
      when(
        () => httpClientMock.get<List<int>>(
          url,
          useBaseUrl: false,
          contentType: 'font/$extension',
          responseType: HttpClientResponseType.bytes,
        ),
      ).thenThrow(HttpClientExceptionMock());

      expect(
        () async => sut.downloadFont(url, extension),
        throwsA(
          isA<Failure>().having((f) => f.message, 'message', isNotEmpty),
        ),
      );
    });

    test('when request fails should log', () async {
      when(
        () => httpClientMock.get<List<int>>(
          url,
          useBaseUrl: false,
          contentType: 'font/$extension',
          responseType: HttpClientResponseType.bytes,
        ),
      ).thenThrow(HttpClientExceptionMock());

      await sut
          .downloadFont(url, extension)
          .onError<Failure>((_, __) => [])
          .whenComplete(
            () => verify(
              () => loggerMock.error(any<String>(), any<dynamic>(), any()),
            ).called(1),
          );
      verifyNoMoreInteractions(loggerMock);
    });
  });
}
