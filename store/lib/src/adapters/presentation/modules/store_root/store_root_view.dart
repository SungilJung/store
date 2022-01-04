import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../../common/logger/logger_utils.dart';
import '../../../../common/message/messages.dart';
import '../../common/custom/bottom_navi/bottom_navi_fab.dart';
import '../../common/custom/bottom_navi/bottom_navi_item.dart';
import '../../common/custom/bottom_navi/custom_bottom_navigator.dart';
import '../../routes/app_pages.dart';
import '../../services/bottom_navi_service.dart';
import '../barcode/view/barcode_view.dart';
import '../barcode/widget/barcode_bottom_sheet.dart';
import '../pb_product/widget/pb_product_category_widget.dart';
import 'controller/store_root_controller.dart';

class StoreRootView extends GetView<StoreRootController> {
  StoreRootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        final currentLocation = currentRoute?.location;
        Get.find<BottomNaviService>().currentLocation(currentLocation);

        var currentIndex = getCurrentIndex(currentLocation);

        var title = currentRoute?.currentPage?.title;

        return KeyboardDismissOnTap(
          child: Scaffold(
            appBar: AppBar(
              title: Text('$title'),
              shadowColor: Colors.transparent,
              backgroundColor: Routes.pbProduct == currentLocation
                  ? Theme.of(context).primaryColor
                  : null,
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
              bottom: Routes.pbProduct == currentLocation
                  ? PreferredSize(
                      preferredSize: Size(Get.width, Get.height * 0.08),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14.0),
                          child: PbProductCategoryWidget(),
                        ),
                      ),
                    )
                  : null,
            ),
            body: Stack(
              children: [
                GetRouterOutlet(
                  initialRoute: Routes.home,
                ),
                BarcodeBottomSheet(
                  height: Get.height * 0.55,
                  child: BarcodeView(),
                ),
              ],
            ),
            bottomNavigationBar: Obx(
              () => Visibility(
                visible: controller.showBottomNavigator,
                child: CustomBottomBar(
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
              ),
            ),
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
