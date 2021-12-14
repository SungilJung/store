part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const search = _Paths.search;

  static const storeRoot = _Paths.storeRoot;
  static const home = _Paths.storeRoot + _Paths.home;
  static const map = _Paths.storeRoot + _Paths.map;
  static const pbProduct = _Paths.storeRoot + _Paths.pbProduct;
  static const favorites = _Paths.storeRoot + _Paths.favorites;
}

abstract class _Paths {
  static const storeRoot = '/store';
  static const home = '/home';
  static const search = '/search';
  static const pbProduct = '/pb';
  static const map = '/map';
  static const favorites = '/favorites';
}
