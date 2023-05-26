import '../../core/exceptions/failure.dart';
import '../../core/http_client/http_client.dart';
import '../../core/http_client/http_client_exception.dart';
import '../../core/logger/logger.dart';
import '../../models/font_filter_item_model.dart';
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
}
