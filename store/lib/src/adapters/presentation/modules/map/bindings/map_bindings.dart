import 'package:get/get.dart';

import '../controller/map_controller.dart';

class MapBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MapController.new);
  }
}
