import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/banner_item.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/api_service.dart';

class RecommendSongService {
  final ApiService _apiService = ApiService();

  Future<List<SongItem>> fetchRecommendSongContent({Map<String, dynamic>? params}) async {
    
    params = {'timestamp': 1714387200, 'size':10,'page':1 };
    final response = await _apiService.get(
      'song/recommend',
      queryParameters: params,
    );

    if (response.statusCode == 200) {
      
      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => SongItem.fromJson(json),
      );
      return apiResponse.data;
    } else {
      throw Exception('Failed to load content');
    }
  }
}


