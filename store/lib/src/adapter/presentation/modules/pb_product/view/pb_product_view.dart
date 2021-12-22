import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../common/logger/logger_utils.dart';
import '../../../routes/app_pages.dart';
import '../../../services/bottom_navi_service.dart';
import '../controller/pb_product_controller.dart';
import '../model/pb_prdocut_model.dart';

class PbProductView extends GetView<PbProductController> {
  const PbProductView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Container(
            height: Get.height * 0.13,
            color: Theme.of(context).primaryColor,
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
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Obx(
                  () => Opacity(
                    opacity: Get.find<BottomNaviService>()
                            .currentLocation
                            .startsWith(Routes.pbProduct)
                        ? 1
                        : 0,
                    child: WebView(
                      initialUrl: controller.models[0].url,
                      onWebViewCreated: (webViewController) {
                        controller.webViewController = webViewController;
                      },
                      onProgress: (progress) {
                        Logger.logNoStack.d('progress $progress');
                      },
                      onPageStarted: (url) {
                        Logger.logNoStack.d('onPageStarted url $url');
                      },
                      onWebResourceError: (error) {
                        Logger.logNoStack
                            .d('onWebResourceError ${error.description}');
                      },
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: [
            _circleAvator(
              Colors.white,
              // image: AssetImage('assetName')
            ),
            Visibility(
                visible: controller.selectedIndex.value != model.index,
                child: _circleAvator(Colors.black.withOpacity(0.3))),
          ],
        ),
      ),
    );
  }

  Widget _circleAvator(Color bgColor, {ImageProvider? image}) {
    return CircleAvatar(
      radius: Get.width * 0.07,
      backgroundColor: bgColor,
      backgroundImage: image,
    );
  }
}
