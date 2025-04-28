import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/banner_item.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/api_service.dart';

class NewSongService {
  final ApiService _apiService = ApiService();

  Future<List<SongItem>> fetchNewSongContent({Map<String, dynamic>? params}) async {
    
    params = {'timestamp': 1714387200,'page':1, 'size':10 };
    final response = await _apiService.get(
      'song/lastest',
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


