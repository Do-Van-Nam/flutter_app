import 'dart:convert';

import 'package:flutter_app/models/api_response.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_app/models/banner_item.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/api_service.dart';

class ArtistService {
  final ApiService _apiService = ApiService();

  Future<Artist> fetchArtistInfo({Map<String, dynamic>? params}) async {
    final response = await _apiService.get(
      'artist/info',
      queryParameters: params,
    );

    if (response.statusCode == 200) {
      final jsonData = response.data;
      final artistInfo = jsonData['data'];
      return Artist.fromJson(artistInfo);
    } else {
      throw Exception('Failed to load content');
    }
  }
}
