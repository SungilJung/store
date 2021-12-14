import 'package:get/get.dart';
import 'package:store/src/adapter/presentation/modules/pb_product/controller/pb_product_controller.dart';

class PbProductBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PbProductController.new);
  }
}
