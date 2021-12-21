import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../../../application/barcode/service/Barcode_formatter.dart';
import '../../../../common/logger/logger_utils.dart';
import '../../../../common/message/messages.dart';
import '../../common/custom/bottom_navi/bottom_navi_fab.dart';
import '../../common/custom/bottom_navi/bottom_navi_item.dart';
import '../../common/custom/bottom_navi/custom_bottom_navigator.dart';
import '../../routes/app_pages.dart';
import '../../services/bottom_navi_service.dart';
import '../barcode/widget/barcode_bottom_sheet.dart';
import '../barcode/widget/mobile_carrier_tab_item.dart';
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
                ),
                BarcodeBottomSheet(
                  height: Get.height * 0.6,
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            Messages.membershipTitle,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        Obx(
                          () => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 60.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: controller.mobileCarriers
                                      .map(
                                        (carrier) => MobileCarrierTabItem(
                                          carrier: carrier,
                                          width: Get.width * 0.25,
                                          color: controller
                                                      .selectedCarrierIndex ==
                                                  carrier.index
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context).disabledColor,
                                          textStyle:
                                              controller.selectedCarrierIndex ==
                                                      carrier.index
                                                  ? Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold)
                                                  : Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!,
                                          onTap: (index) {
                                            controller
                                                .selectedCarrierIndex(index);
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: BarcodeWidget(
                                    height: Get.height * 0.13,
                                    data: 'data',
                                    barcode: Barcode.code128(),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        '${controller.selectedCarrierName} ${Messages.membership}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          BarcodeInputFormatter(),
                                        ],
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary),
                                          labelText:
                                              Messages.inputMembershipCode,
                                          fillColor: Colors.transparent,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
