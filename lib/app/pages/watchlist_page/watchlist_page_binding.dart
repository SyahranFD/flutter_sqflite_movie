import 'package:flutter_sqflite_movie/app/pages/watchlist_page/watchlist_page_controller.dart';
import 'package:get/get.dart';

class WatchlistPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchlistPageController>(
          () => WatchlistPageController(),
    );
  }
}
