import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/pb_product_service.dart';
import '../model/pb_prdocut_model.dart';

class PbProductCategoryWidget extends GetWidget<PbProductSerivce> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: controller.models
            .map((model) => _createRowItem(context, model))
            .toList(),
      ),
    );
  }

  Widget _createRowItem(BuildContext context, PbProductModel model) {
    return GestureDetector(
      onTap: () {
        controller.selectedIndex(model.index);
        controller.webViewController
            .loadUrl(controller.models[controller.selectedIndex.value].url);
      },
      child: Container(
        height: context.isTablet ? Get.height * 0.07 : null,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            _circleAvator(Colors.white,
                image: Image.asset(
                  model.logo.path,
                  fit: BoxFit.cover,
                  isAntiAlias: true,
                  filterQuality: FilterQuality.high,
                  scale: context.isTablet ? 0.5 : 1,
                )),
            Visibility(
                visible: controller.selectedIndex.value != model.index,
                child: _circleAvator(Colors.black.withOpacity(0.3))),
          ],
        ),
      ),
    );
  }

  Widget _circleAvator(Color bgColor, {Widget? image}) {
    return CircleAvatar(
      radius: Get.width * 0.07,
      backgroundColor: bgColor,
      child: image,
    );
  }
}
