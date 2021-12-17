import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/logger/logger_utils.dart';
import '../controller/pb_product_controller.dart';
import '../model/pb_prdocut_model.dart';

class PbProductView extends GetView<PbProductController> {
  const PbProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        title: Text('PB 상품'),
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            splashColor: Colors.transparent,
            onPressed: () {
              Logger.logNoStack.d('search!!');
            },
          )
        ],
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            height: Get.height * 0.13,
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: controller.models
                    .map((model) => _createRowItem(context, model))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createRowItem(BuildContext context, PbProductModel model) {
    var width = Get.width * 0.15;
    var height = Get.width * 0.15;

    return GestureDetector(
      onTap: () => controller.selectedIndex(model.index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            _circleContainer(
              Colors.white,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: model.image,
              ),
            ),
            Visibility(
                visible: controller.selectedIndex.value != model.index,
                child: _circleContainer(Colors.black.withOpacity(0.3))),
          ],
        ),
      ),
    );
  }

  Widget _circleContainer(Color bgColor, {DecorationImage? image}) {
    var width = Get.width * 0.15;
    var height = Get.width * 0.15;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        image: image,
      ),
    );
  }
}
