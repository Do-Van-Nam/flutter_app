import 'package:dio/dio.dart';
import 'landing_content_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<LandingContentItem>> fetchLandingContent() async {
    final response = await _dio.get(
      'https://freeapikakoak.tls.tl/RingMeAPI/landing-page/get-content',
    );

    if (response.statusCode == 200) {
      final data = LandingContentResponse.fromJson(response.data);
      return data.data;
    } else {
      throw Exception('Failed to load content');
    }
  }
}
