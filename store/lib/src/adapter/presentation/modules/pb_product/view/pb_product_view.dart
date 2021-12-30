import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../common/logger/logger_utils.dart';
import '../../../routes/app_pages.dart';
import '../../../services/bottom_navi_service.dart';
import '../../../services/pb_product_service.dart';

class PbProductView extends GetView<PbProductSerivce> {
  const PbProductView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => Visibility(
              visible: Get.find<BottomNaviService>()
                  .currentLocation
                  .startsWith(Routes.pbProduct),
              child: Container(
                color: Theme.of(context).primaryColor,
                height: Get.height * 0.02,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Obx(
              () => Opacity(
                opacity: Get.find<BottomNaviService>()
                        .currentLocation
                        .startsWith(Routes.pbProduct)
                    ? 1
                    : 0,
                child: WebView(
                  initialUrl:
                      controller.models[controller.selectedIndex.value].url,
                  onWebViewCreated: (webViewController) {
                    controller.webViewController = webViewController;
                  },
                  onProgress: (progress) {
                    if (progress == 100 &&
                        GetPlatform.isAndroid &&
                        controller.models[controller.selectedIndex.value].url
                            .startsWith(controller.sevenElevenBaseUrl)) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        controller.webViewController
                            .runJavascript(controller.replaceProtocolStript);
                      });
                    }
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
        ],
      ),
    );
  }
}
