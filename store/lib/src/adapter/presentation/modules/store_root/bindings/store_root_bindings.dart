import 'package:get/get.dart';

import '../controller/store_root_controller.dart';

class StoreRootBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreRootController());
  }
}
