import 'dart:convert';

import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/recommend_song_item.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/api_service.dart';

class RecommendSongService {
  final ApiService _apiService = ApiService();

  Future<List<SongItem>> fetchRecommendSongContent({Map<String, dynamic>? params}) async {
    
    params = {'timestamp': 1714387200, 'size':20,'page':1 };
    final response = await _apiService.get(
      'song/recommend',
      queryParameters: params,
    );

    if (response.statusCode == 200) {
      dynamic responseData = response.data;
  
  // Nếu responseData là String, thì decode JSON ra Map
  if (responseData is String) {
    responseData = jsonDecode(responseData);
  }
      final apiResponse = ApiResponse.fromJson(
        responseData,
        (json) => SongItem.fromJson(json),
      );
      return apiResponse.data;
    } else {
      throw Exception('Failed to load content');
    }
  }
}


