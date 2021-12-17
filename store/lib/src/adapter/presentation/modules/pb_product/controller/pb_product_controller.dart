import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/pb_prdocut_model.dart';

class PbProductController extends GetxController {
  final List<PbProductModel> models = [
    PbProductModel(
      index: 0,
      url: 'http://gs25.gsretail.com/gscvs/ko/products/youus-main',
      image: NetworkImage(
          'https://e7.pngegg.com/pngimages/168/424/png-clipart-logo-gs25-brand-corporate-identity-product-gs-text-trademark-thumbnail.png'),
    ),
    PbProductModel(
      index: 1,
      url: 'https://cu.bgfretail.com/product/pb.do?category=product&sf=N',
      image: NetworkImage(
          'https://e7.pngegg.com/pngimages/751/667/png-clipart-south-korea-cu-convenience-shop-7-eleven-chain-store-ai-file-purple-violet-thumbnail.png'),
    ),
    PbProductModel(
      index: 2,
      url: 'https://m.7-eleven.co.kr:444/product/productList.asp',
      image: NetworkImage(
          'https://cdn.imgbin.com/18/22/12/imgbin-7-eleven-slurpee-logo-convenience-shop-restaurant-others-QpKSkj7cTQ47EwJKPCG7zqrRA.jpg'),
    ),
    PbProductModel(
      index: 3,
      url: 'https://m.emart24.co.kr/product?cat=DP',
      image: NetworkImage('http://www.emart24.co.kr/images/common/S-LOGO.png'),
    ),
    PbProductModel(
      index: 4,
      url: 'https://www.ministop.co.kr/MiniStopHomePage/page/m/guide/list3.do',
      image: NetworkImage(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/MINISTOP_logo.svg/1280px-MINISTOP_logo.svg.png'),
    ),
  ];

  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (GetPlatform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
}
