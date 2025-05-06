import 'package:flutter_app/models/author.dart';

import 'artist.dart';

class SongItem {
  final int id;
  String? countryCode;
  final String songName;
  final String avatar;
  final String mediaPath;
  final int bitRate;
  final int duration;
  final int? isDownload;
  final int totalListens;
  final int totalDownload;
  final int totalLiked;
  final int totalShared;
  final int totalComment;
  final String? countryNameVn;
  final String? countryNameEn;
  final bool? hasLyric;
  final int isLike;
  final Author? author;
  final int numberOfArtists;
  final List<Artist> artists;
  final String link;

  SongItem({
    required this.id,
    this.countryCode,
    required this.songName,
    required this.avatar,
    required this.mediaPath,
    required this.bitRate,
    required this.duration,
    this.isDownload,
    required this.totalListens,
    required this.totalDownload,
    required this.totalLiked,
    required this.totalShared,
    required this.totalComment,
    this.countryNameVn,
    this.hasLyric,
    this.countryNameEn,
    required this.isLike,
    this.author,
    required this.numberOfArtists,
    required this.artists,
    required this.link,
  });

  factory SongItem.fromJson(Map<String, dynamic> json) {
    return SongItem(
      id: json['id'] ?? 0, // Default to 0 if null
      songName: json['songName'] ?? 'Unknown', // Default to 'Unknown' if null
      avatar: json['avatar'] ?? '', // Default to empty string if null
      mediaPath: json['mediaPath'] ?? '',
      bitRate: json['bitRate'] ?? 0, // Default to 0 if null
      duration: json['duration'] ?? 0, // Default to 0 if null
      isDownload: json['isDownload'], // Optional field, can be null
      totalListens: json['totalListens'] ?? 0, // Default to 0 if null
      totalDownload: json['totalDownload'] ?? 0, // Default to 0 if null
      totalLiked: json['totalLiked'] ?? 0, // Default to 0 if null
      totalShared: json['totalShared'] ?? 0, // Default to 0 if null
      totalComment: json['totalComment'] ?? 0, // Default to 0 if null
      countryNameEn: json['countryNameEn'] ?? '', // Default to empty string if null
      countryNameVn: json['countryNameVn'] ?? '',
      hasLyric: json['hasLyric'], // Optional field, can be null
      isLike: json['isLike'] ?? 0, // Default to 0 if null
      author: json['author'] != null ? Author.fromJson(json['author']) : null, // Default to null if not present
      numberOfArtists: json['numberOfArtists'] ?? 0, // Default to 0 if null
      artists: (json['artists'] as List<dynamic>?)
              ?.map((artistJson) => Artist.fromJson(artistJson))
              .toList() ??
          [], // Handle null artists list
      link: json['link'] ?? '', // Default to empty string if null
      countryCode: json['countryCode'], // Optional field, can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'songName': songName,
      'avatar': avatar,
      'mediaPath': mediaPath,
      'bitRate': bitRate,
      'duration': duration,
      'isDownload': isDownload,
      'totalListens': totalListens,
      'totalDownload': totalDownload,
      'totalLiked': totalLiked,
      'totalShared': totalShared,
      'totalComment': totalComment,
      'countryNameVn': countryNameVn,
      'countryNameEn': countryNameEn,
      'hasLyric': hasLyric,
      'isLike': isLike,
      'author': author?.toJson(),
      'numberOfArtists': numberOfArtists,
      'artists': artists.map((artist) => artist.toJson()).toList(),
      'link': link,
      'countryCode': countryCode,
    };
  }
}

