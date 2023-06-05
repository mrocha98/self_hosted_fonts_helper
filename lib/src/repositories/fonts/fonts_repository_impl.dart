import 'dart:io';

import '../../core/exceptions/failure.dart';
import '../../core/exceptions/font_not_found_execption.dart';
import '../../core/http_client/http_client.dart';
import '../../core/http_client/http_client_exception.dart';
import '../../core/http_client/http_client_response_type.dart';
import '../../core/logger/logger.dart';
import '../../models/font_filter_item_model.dart';
import '../../models/font_model.dart';
import 'fonts_repository.dart';

class FontsRepositoryImpl implements FontsRepository {
  FontsRepositoryImpl(this._httpClient, this._logger);

  final HttpClient _httpClient;

  final Logger _logger;

  @override
  Future<List<FontFilterItemModel>> getFilterFonts() async {
    try {
      final response = await _httpClient.get<List<dynamic>>('/fonts');
      final data =
          List<Map<String, dynamic>>.from(response.data, growable: false);
      return data
          .map<FontFilterItemModel>(FontFilterItemModel.fromMap)
          .toList(growable: false);
    } on HttpClientException<dynamic> catch (e, st) {
      const message = 'Failed to get fonts';
      _logger.error(message, e, st);
      throw Failure(message);
    }
  }

  @override
  Future<FontModel> getFont(String id, List<String> subsets) async {
    try {
      final response = await _httpClient.get<Map<String, dynamic>>(
        '/fonts/$id',
        queryParameters: {'subsets': subsets.join(',')},
      );
      return FontModel.fromMap(response.data);
    } on HttpClientException<dynamic> catch (e, st) {
      if (e.statusCode == HttpStatus.notFound) {
        _logger.error('Font $id with $subsets not found', e, st);
        throw FontNotFoundExecption();
      }
      final message = 'Failed to get font $id with subsets $subsets';
      _logger.error(message, e, st);
      throw Failure(message);
    }
  }

  @override
  Future<List<int>> downloadFont(String url, String extension) async {
    try {
      final response = await _httpClient.get<List<int>>(
        url,
        useBaseUrl: false,
        contentType: 'font/$extension',
        responseType: HttpClientResponseType.bytes,
      );
      return response.data;
    } on HttpClientException<dynamic> catch (e, st) {
      const message = 'Failed to download font';
      _logger.error(message, e, st);
      throw Failure(message);
    }
  }
}
