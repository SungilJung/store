import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/logger/logger_utils.dart';
import '../../../../common/message/messages.dart';
import '../../common/custom/bottom_navi/bottom_navi_fab.dart';
import '../../common/custom/bottom_navi/bottom_navi_item.dart';
import '../../common/custom/bottom_navi/custom_bottom_navigator.dart';
import '../../routes/app_pages.dart';
import 'controller/store_root_controller.dart';

class StoreRootView extends GetView<StoreRootController> {
  StoreRootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        final currentLocation = currentRoute?.location;
        var currentIndex = getCurrentIndex(currentLocation);
        var title = currentRoute?.currentPage?.title;

        return Scaffold(
          appBar: AppBar(
            title: Text('$title'),
            shadowColor: Colors.transparent,
            centerTitle: false,
            elevation: 0.0,
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                splashColor: Colors.transparent,
                onPressed: () {
                  Logger.logNoStack.d('search!!');
                },
              )
            ],
          ),
          body: Stack(
            children: [
              GetRouterOutlet(
                initialRoute: Routes.home,
                key: Get.nestedKey(Routes.storeRoot),
              ),
              _CustomBottomSheet(
                height: Get.height * 0.8,
                controller: controller,
                child: Container(
                  color: Colors.amber,
                  child: Center(
                    child: Text('hi'),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            currentIndex: currentIndex,
            iconSize: 26,
            fab: BottomNaviFAB(
              icon: Icon(
                Icons.qr_code,
                color: Colors.deepOrange,
                size: 45,
              ),
              onFabTap: () {
                controller.showBarcode.toggle();
              },
            ),
            items: [
              BottomNaviItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: Messages.home,
              ),
              BottomNaviItem(
                icon: Icon(
                  Icons.camera_rear_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                activeIcon: Icon(
                  Icons.camera_rear,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: Messages.pbProduct,
              ),
              BottomNaviItem(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                activeIcon: Icon(
                  Icons.location_on,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: Messages.map,
              ),
              BottomNaviItem(
                icon: Icon(
                  Icons.favorite_border,
                  color: Theme.of(context).iconTheme.color,
                ),
                activeIcon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: Messages.favoriteProduct,
              ),
            ],
            onTap: (value) {
              controller.showBarcode(false);

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

class _CustomBottomSheet extends StatelessWidget {
  final StoreRootController controller;
  final Widget child;
  final double height;

  const _CustomBottomSheet({
    Key? key,
    required this.controller,
    required this.child,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () => controller.showBarcode.toggle(),
              child: Visibility(
                visible: controller.showBarcode.value,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  width: Get.width,
                  height: Get.height,
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: controller.showBarcode.value ? 0 : -(height),
              right: 0.0,
              left: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                ),
                width: Get.width,
                height: height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: 60,
                        height: 5,
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    Expanded(child: child),
                  ],
                ),
              ),
              duration: Duration(milliseconds: 300),
              curve: Curves.decelerate,
            ),
          ],
        );
      },
    );
  }
}
