import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/logger/logger_utils.dart';
import '../../common/custom/bottom_navi/bottom_navi_fab.dart';
import '../../common/custom/bottom_navi/bottom_navi_item.dart';
import '../../common/custom/bottom_navi/custom_bottom_navigator.dart';
import '../../routes/app_pages.dart';

class StoreRootView extends StatelessWidget {
  StoreRootView({Key? key}) : super(key: key);

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
          bottomNavigationBar: CustomBottomBar(
            currentIndex: currentIndex,
            iconSize: 26,
            fab: BottomNaviFAB(
              icon: Icon(
                Icons.qr_code,
                color: Colors.deepOrange,
                size: 45,
              ),
              onFabTap: () {
                Logger.logNoStack.d('FAB!!!');
                Get.snackbar(
                  '바코드',
                  '바코트 클릭',
                  duration: Duration(seconds: 1),
                );
              },
            ),
            items: [
              BottomNaviItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNaviItem(
                icon: Icon(Icons.camera_rear_outlined),
                activeIcon: Icon(Icons.camera_rear),
                label: 'PB 상품',
              ),
              BottomNaviItem(
                icon: Icon(Icons.location_on_outlined),
                activeIcon: Icon(Icons.location_on),
                label: '지도',
              ),
              BottomNaviItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: '찜한 상품',
              ),
            ],
            onTap: (value) {
              switch (value) {
                case 0:
                  delegate.offAndToNamed(Routes.home);
                  break;
                case 1:
                  delegate.offAndToNamed(Routes.pbProduct);
                  break;
                case 2:
                  delegate.offAndToNamed(Routes.map);
                  break;
                case 3:
                  delegate.offAndToNamed(Routes.favorites);
                  break;
                default:
                  break;
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
      index = 2;
    } else if (true == currentLocation?.startsWith(Routes.favorites)) {
      index = 3;
    }
    return index;
  }
}
