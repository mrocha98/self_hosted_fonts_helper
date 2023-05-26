import 'package:mocktail/mocktail.dart';
import 'package:self_hosted_fonts_helper/src/core/http_client/http_client_exception.dart';

class HttpClientExceptionMock extends Mock
    implements HttpClientException<dynamic> {}
