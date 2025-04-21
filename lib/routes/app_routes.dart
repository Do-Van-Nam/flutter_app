part of 'app_pages.dart';

abstract class Routes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const EXPLORE = '/explore';
  static const LIBRARY = '/library';
  static const LIBRARY_PLAYLIST = '/library/playlist';
  static const LIBRARY_ALBUM = '/library/album';
  static const LIBRARY_ARTIST = '/library/artist';
  static const EXPLORE_CATEGORY = '/explore/category';
  static const EXPLORE_CATEGORY_DETAIL = '/explore/category/:slug';
  static const EXPLORE_RANKING = '/explore/ranking';
  static const EXPLORE_RANKING_DETAIL = '/explore/ranking/:slug';
  static const EXPLORE_NEW_RELEASE = '/explore/new-release';
  static const MUSIC_DETAIL = '/music-detail';
  static const SETTINGS = '/settings';
}
