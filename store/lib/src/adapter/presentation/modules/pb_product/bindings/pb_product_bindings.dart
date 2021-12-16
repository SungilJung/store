import 'package:get/get.dart';

import '../controller/pb_product_controller.dart';

class PbProductBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PbProductController.new);
  }
}
