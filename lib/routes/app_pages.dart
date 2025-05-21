import 'package:flutter/services.dart';
import 'package:flutter_app/ui/pages/explore/explore_ranking_detail.dart';
import 'package:flutter_app/ui/pages/home/new_song_detail.dart';
import 'package:flutter_app/ui/pages/home/recommend_song_detail.dart';
import 'package:flutter_app/ui/pages/library/artist_detail.dart';
import 'package:flutter_app/ui/pages/library/library_screen.dart';
import 'package:flutter_app/ui/pages/library/playlist_detail.dart';
import 'package:flutter_app/ui/pages/personal/personal_screen.dart';
import 'package:flutter_app/ui/pages/playing/playing_screen.dart';
import 'package:flutter_app/ui/pages/profile/profile_screen.dart';
import 'package:flutter_app/ui/pages/results/results_screen.dart';
import 'package:flutter_app/ui/pages/ringstone/ringstone_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_app/ui/pages/home/home_binding.dart';
import 'package:flutter_app/ui/pages/explore/explore_screen.dart';
import 'package:flutter_app/ui/pages/explore/explore_category.dart';
import 'package:flutter_app/ui/pages/explore/explore_category_detail.dart';
import 'package:flutter_app/ui/pages/explore/explore_ranking.dart';
import 'package:flutter_app/ui/pages/explore/explore_new_release.dart';
import 'package:flutter_app/ui/pages/home/home_page.dart';
import 'package:flutter_app/ui/pages/home/home_screen.dart';
import 'package:flutter_app/ui/pages/login/login_binding.dart';
import 'package:flutter_app/ui/pages/login/login_page.dart';
import 'package:flutter_app/ui/pages/music_detail/music_detail_binding.dart';
import 'package:flutter_app/ui/pages/music_detail/music_detail_page.dart';
import 'package:flutter_app/ui/pages/settings/settings_binding.dart';
import 'package:flutter_app/ui/pages/settings/settings_page.dart';
import 'package:flutter_app/ui/pages/splash/splash_binding.dart';
import 'package:flutter_app/ui/pages/splash/splash_page.dart';

part 'app_routes.dart';

class AppPages {
  // static const INITIAL = Routes.SPLASH;
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      // page: () => HomePage(),
      // binding: HomeBinding(),
      page: () => HomeScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.EXPLORE,
      // page: () => ExplorePage(),
      // binding: ExploreBinding(),
      page: () => ExploreScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.ARTIST_DETAIL,
      // page: () => ExplorePage(),
      // binding: ExploreBinding(),
      page: () => ArtistDetailScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.PROFILE,
      // page: () => ProfilePage(),
      // binding: ProfileBinding(),
      page: () => ProfileScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.PLAYING,
      page: () => PlayingScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.RESULTS,
      page: () => ResultsScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.LIBRARY,
      // page: () => HomePage(),
      // binding: HomeBinding(),
      page: () => LibraryScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.LIBRARY_PLAYLIST_DETAIL,
      // page: () => HomePage(),
      // binding: HomeBinding(),
      page: () => LibraryPlaylistDetailScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.EXPLORE_CATEGORY,
      // page: () => HomePage(),
      // binding: HomeBinding(),
      page: () => ExploreCategoryScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.EXPLORE_NEW_RELEASE,
      // page: () => HomePage(),
      // binding: HomeBinding(),
      page: () => ExploreNewReleaseScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.EXPLORE_CATEGORY_DETAIL,
      // page: () => HomePage(),
      // binding: HomeBinding(),
      page: () => ExploreCategoryDetailScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),

    GetPage(
      name: Routes.EXPLORE_RANKING,
      // page: () => HomePage(),
      // binding: HomeBinding(),
      page: () => ExploreRankingScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.EXPLORE_RANKING_DETAIL,
      // page: () => HomePage(),
      // binding: HomeBinding(),
      page: () => ExploreRankingDetailScreen(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.MUSIC_DETAIL,
      page: () => MusicDetailPage(),
      binding: MusicDetailBinding(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsPage(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.NEWSONG,
      page: () => NewSongDetailScreen(),

      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.RECOMMEND_SONG,
      page: () => RecommendSongDetailScreen(),

      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.RINGSTONE,
      page: () => RingstoneScreen(),

      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.PERSONAL,
      page: () => PersonalScreen(),

      transition: Transition.rightToLeft, // hoặc fade, rightToLeft, zoom, ...
      transitionDuration: Duration(milliseconds: 300),
    ),
  ];
}
