import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../store_root/controller/store_root_controller.dart';

class BarcodeBottomSheet extends GetWidget<StoreRootController> {
  final Widget child;
  final double height;

  const BarcodeBottomSheet({
    Key? key,
    required this.child,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return _createContents(context);
    } else {
      return BackButtonListener(
        child: _createContents(context),
        onBackButtonPressed: () {
          var preShowBarcode = controller.showBarcode.value;
          controller.showBarcode(false);

          return Future.value(preShowBarcode);
        },
      );
    }
  }

  Obx _createContents(BuildContext context) {
    return Obx(
      () {
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () {
                controller.showBarcode.toggle();

                var currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              },
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
