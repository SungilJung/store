import 'package:get/get.dart';
import 'package:store/src/adapter/presentation/modules/store_root/controller/store_root_controller.dart';

class StoreRootBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(StoreRootController());
  }
}
