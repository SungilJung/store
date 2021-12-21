import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/logo.dart';
import '../model/pb_prdocut_model.dart';

class PbProductController extends GetxController {
  final List<PbProductModel> models = [
    PbProductModel(
      index: 0,
      url: 'http://gs25.gsretail.com/gscvs/ko/products/event-goods',
      logo: Logo(''),
    ),
    PbProductModel(
      index: 1,
      url:
          'http://cu.bgfretail.com/product/pb.do?category=product&depth2=1&sf=N',
      logo: Logo(''),
    ),
    PbProductModel(
      index: 2,
      url:
          'https://m.7-eleven.co.kr:444/product/productList.asp?pTab=5&pCd=&intPageSize=4',
      logo: Logo(''),
    ),
    PbProductModel(
      index: 3,
      url: 'https://m.emart24.co.kr/product?cat=DP',
      logo: Logo(''),
    ),
    PbProductModel(
      index: 4,
      url: 'https://www.ministop.co.kr/MiniStopHomePage/page/m/guide/list3.do',
      logo: Logo(''),
    ),
  ];

  final RxInt selectedIndex = 0.obs;
  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    if (GetPlatform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
}
