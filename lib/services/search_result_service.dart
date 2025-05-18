import 'dart:convert';

import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/collection.dart';
import 'package:flutter_app/models/rank_list.dart';
import 'package:flutter_app/models/recommend_song_item.dart';
import 'package:flutter_app/models/search_result.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/api_service.dart';

class SearchResultService {
  final ApiService _apiService = ApiService();

  Future<List<Group>> fetchSearchResultContent({
    Map<String, dynamic>? params,
  }) async {
    // params = {'timestamp': 1714387200,'page':1, 'size':10  };
    final response = await _apiService.get(
      'search/all',
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
        (json) => Group.fromJson(json),
      );
      return apiResponse.data;
    } else {
      throw Exception('Failed to load content');
    }
  }
}
