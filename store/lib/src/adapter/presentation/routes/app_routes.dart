part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  // static const location = _Paths.location;
  // static const shops = _Paths.shops;

  // static const shopsDashbard = _Paths.shops + _Paths.dashboard;
  // static String shopDetails(String shopId) => '${_Paths.shops}/$shopId';
  // static String shopInfos(String shopId) => shopDetails(shopId) + _Paths.info;

  // static const events = _Paths.events;
  // static const coupons = _Paths.coupons;
  // static const favorite = _Paths.favorites;
  // static String search(String keyword) => '${_Paths.search}?keyword=$keyword';

  // static const home = _Paths.home;
  // static const dashboard = _Paths.home + _Paths.dashboard;
  // static const homeSearch = _Paths.home + _Paths.search;
  // static const orders = _Paths.home + _Paths.orders;
  // static const profile = _Paths.home + _Paths.profile;
}

abstract class _Paths {
  static const location = '/location';
  static const shops = '/shops';
  static const info = '/info';
  static const shopDetails = '/:shopId';
  static const events = '/events';
  static const coupons = '/coupons';
  static const favorites = '/favorites';

  static const home = '/home';
  static const dashboard = '/dashboard';
  static const search = '/search';
  static const orders = '/orders';
  static const profile = '/profile';
}
