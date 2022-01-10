import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../../applications/map/application/port/out/get_cached_store_location_port.dart';
import '../../applications/map/application/port/out/save_store_location_port.dart';
import '../../applications/map/domain/store_location.dart';

class CachedStoreLocationAdatper
    with GetCachedStoreLocationPort, SaveStoreLocationPort {
  final _keyStoreLocation = 'store_location';

  @override
  List<StoreLocation> getStoreLocations() {
    var box = GetStorage();
    var results = <StoreLocation>[];

    if (box.hasData(_keyStoreLocation)) {
      String receivedJson = box.read(_keyStoreLocation);
      List<dynamic> jsonDatas = json.decode(receivedJson);
      results = jsonDatas
          .map((e) => StoreLocation.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return results;
  }

  @override
  void saveStoreLocation(List<StoreLocation> storeLocations) {
    var box = GetStorage();
    box.write(_keyStoreLocation, jsonEncode(storeLocations));
  }
}
