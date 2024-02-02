import 'package:flutter_sqflite_movie/app/pages/home_page/home_page_binding.dart';
import 'package:flutter_sqflite_movie/app/pages/home_page/home_page_view.dart';
import 'package:flutter_sqflite_movie/app/pages/watchlist_page/watchlist_page_binding.dart';
import 'package:flutter_sqflite_movie/app/pages/watchlist_page/watchlist_page_view.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  // static var routes;

  AppPages._();

  static const INITIAL = Routes.HOME_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.WATCHLIST_PAGE,
      page: () => WatchlistPageView(),
      binding: WatchlistPageBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
