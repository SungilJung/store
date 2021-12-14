import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import 'controller/store_root_controller.dart';

class StoreRootView extends GetView<StoreRootController> {
  const StoreRootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        final currentLocation = currentRoute?.location;
        var currentIndex = getCurrentIndex(currentLocation);

        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: Routes.home,
            key: Get.nestedKey(Routes.storeRoot),
          ),
          bottomNavigationBar: ConvexAppBar(
            items: [
              TabItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                title: '홈',
              ),
              TabItem(
                icon: Icon(Icons.camera_rear_outlined),
                activeIcon: Icon(Icons.camera_rear),
                title: 'PB상품',
              ),
              TabItem(
                icon: Icon(
                  Icons.qr_code_rounded,
                  color: Colors.pink,
                ),
                title: '바코드',
              ),
              TabItem(
                icon: Icon(Icons.map_outlined),
                activeIcon: Icon(Icons.map),
                title: '지도',
              ),
              TabItem(
                  icon: Icon(Icons.favorite_border),
                  activeIcon: Icon(Icons.favorite),
                  title: '찜한 상품'),
            ],
            style: TabStyle.fixedCircle,
            curveSize: 75,
            backgroundColor: Colors.white,
            activeColor: Colors.black,
            color: Colors.black,
            onTap: (value) {
              switch (value) {
                case 0:
                  delegate.toNamed(Routes.home);
                  break;
                case 1:
                  delegate.toNamed(Routes.pbProduct);
                  break;
                case 2:
                  break;
                case 3:
                  delegate.toNamed(Routes.map);
                  break;
                case 4:
                  delegate.toNamed(Routes.favorites);
                  break;
                default:
              }
            },
          ),
        );
      },
    );
  }

  int getCurrentIndex(String? currentLocation) {
    var index = 0;

    if (true == currentLocation?.startsWith(Routes.pbProduct)) {
      index = 1;
    } else if (true == currentLocation?.startsWith(Routes.map)) {
      index = 3;
    } else if (true == currentLocation?.startsWith(Routes.favorites)) {
      index = 4;
    }
    return index;
  }
}
