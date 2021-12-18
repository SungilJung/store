import 'package:get/get.dart';
import '../../../common/message/messages.dart';

import '../modules/favorite/bindings/favorite_bindings.dart';
import '../modules/favorite/view/favorite_view.dart';
import '../modules/home/bindings/home_bindings.dart';
import '../modules/home/view/home_view.dart';
import '../modules/map/bindings/map_bindings.dart';
import '../modules/map/view/map_view.dart';
import '../modules/pb_product/bindings/pb_product_bindings.dart';
import '../modules/pb_product/view/pb_product_view.dart';
import '../modules/root/root_view.dart';
import '../modules/store_root/bindings/store_root_bindings.dart';
import '../modules/store_root/store_root_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: '/',
      title: Messages.home,
      page: () => const RootView(),
      participatesInRootNavigator: true,
      children: [
        GetPage(
          title: Messages.home,
          name: _Paths.storeRoot,
          page: StoreRootView.new,
          binding: StoreRootBindings(),
          children: [
            GetPage(
              title: Messages.home,
              name: _Paths.home,
              page: HomeView.new,
              binding: HomeBindings(),
              transition: Transition.fadeIn,
              transitionDuration: Duration(milliseconds: 500),
            ),
            GetPage(
              title: Messages.pbProduct,
              name: _Paths.pbProduct,
              page: () => const PbProductView(),
              binding: PbProductBindings(),
              transition: Transition.fadeIn,
              transitionDuration: Duration(milliseconds: 500),
            ),
            GetPage(
              title: Messages.map,
              name: _Paths.map,
              page: () => const MapView(),
              binding: MapBindings(),
              transition: Transition.fadeIn,
              transitionDuration: Duration(milliseconds: 500),
            ),
            GetPage(
              title: Messages.favoriteProduct,
              name: _Paths.favorites,
              page: () => const FavoriteView(),
              binding: FavoriteBindings(),
              transition: Transition.fadeIn,
              transitionDuration: Duration(milliseconds: 500),
            ),
          ],
        ),
      ],
    ),
  ];
}
