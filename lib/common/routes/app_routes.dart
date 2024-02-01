part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME_PAGE = _Paths.HOME_PAGE;
  static const WATCHLIST_PAGE = _Paths.WATCHLIST_PAGE;
}

abstract class _Paths {
  _Paths._();
  static const HOME_PAGE = '/';
  static const WATCHLIST_PAGE = '/watchlist';
}
