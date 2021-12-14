import 'package:get/get.dart';

import '../controller/favorite_controller.dart';

class FavoriteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(FavoriteController.new);
  }
}
