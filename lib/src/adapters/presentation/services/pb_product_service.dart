import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../modules/pb_product/model/logo.dart';
import '../modules/pb_product/model/pb_prdocut_model.dart';

class PbProductSerivce extends GetxService {
  final String replaceProtocolStript =
      '\$(document).ready(function() { \$("img").each(function() { var i = \$(this).attr("src"); var n = i.replace("http://", "https://"); \$(this).attr("src", function() { return n; }) }) });';

  final String sevenElevenBaseUrl = 'https://m.7-eleven';

  final List<PbProductModel> models = [
    PbProductModel(
      index: 0,
      url: 'http://gs25.gsretail.com/gscvs/ko/products/event-goods',
      logo: Logo('assets/store/category/gs25.png'),
    ),
    PbProductModel(
      index: 1,
      url:
          'http://cu.bgfretail.com/product/pb.do?category=product&depth2=1&sf=N',
      logo: Logo('assets/store/category/cu.png'),
    ),
    PbProductModel(
      index: 2,
      url:
          'https://m.7-eleven.co.kr:444/product/productList.asp?pTab=5&pCd=&intPageSize=4',
      logo: Logo('assets/store/category/7eleven.png'),
    ),
    PbProductModel(
      index: 3,
      url: 'https://m.emart24.co.kr/product?cat=DP',
      logo: Logo('assets/store/category/emart24.png'),
    ),
    PbProductModel(
      index: 4,
      url: 'https://www.ministop.co.kr/MiniStopHomePage/page/m/guide/list3.do',
      logo: Logo('assets/store/category/ministop.png'),
    ),
  ];

  final RxInt selectedIndex = 0.obs;
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    if (GetPlatform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
}
