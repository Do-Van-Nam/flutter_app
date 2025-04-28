import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/banner_item.dart';
import 'package:flutter_app/services/api_service.dart';

class BannerService {
  final ApiService _apiService = ApiService();

  Future<List<BannerItem>> fetchBannerContent({Map<String, dynamic>? params}) async {
    
    params = {'timestamp': 1714387200, 'size':100,'page':10 };
    final response = await _apiService.get(
      'banner/list',
      queryParameters: params,
    );

    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => BannerItem.fromJson(json),
      );
      return apiResponse.data;
    } else {
      throw Exception('Failed to load content');
    }
  }
}


