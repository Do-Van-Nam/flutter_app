import 'dart:convert';

import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/collection.dart';
import 'package:flutter_app/models/rank_list.dart';
import 'package:flutter_app/models/recommend_song_item.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/api_service.dart';

class CollectionDetailService {
  final ApiService _apiService = ApiService();

  Future<Collection> fetchCollectionDetailContent({
    Map<String, dynamic>? params,
  }) async {
    // params = {'timestamp': 1714387200, 'collectionId': 1};
    final response = await _apiService.get(
      'genre/collection/detail',
      queryParameters: params,
    );

    if (response.statusCode == 200) {
      dynamic responseData = response.data;

      // Nếu responseData là String, thì decode JSON ra Map
      if (responseData is String) {
        responseData = jsonDecode(responseData);
      }
      
      return Collection.fromJson(responseData['data']);
    } else {
      throw Exception('Failed to load content');
    }
  }
}
