import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../applications/map/application/service/get_store_location_service.dart';
import '../../../../network/rest/map/remote_store_location_adatper.dart';
import '../../../../persistance/cached_coordinates_adapter.dart';
import '../../../../persistance/cached_store_location_adapter.dart';
import '../controller/map_controller.dart';

class MapBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MapController.new);
    Get.lazyPut(CachedCoordinatesAdapter.new);
    Get.lazyPut(CachedStoreLocationAdatper.new);
    Get.lazyPut(() => RemoteStoreLocationAdapter(Get.find<Dio>()));
    Get.lazyPut(() => GetStoreLocationService(
          getCachedStoreLocationPort: Get.find<CachedStoreLocationAdatper>(),
          getRemoteStoreLocationPort: Get.find<RemoteStoreLocationAdapter>(),
        ));
  }
}
