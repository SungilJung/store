import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../applications/map/application/port/out/get_cached_coordinates_port.dart';
import '../../applications/map/application/port/out/save_store_coordinates_port.dart';
import '../../applications/map/domain/serialiser/lat_lng_serialiser.dart';

class CachedCoordinatesAdapter
    with SaveStoreCoordinatesPort, GetCachedCoordinatesPort {
  final _keyCoordinates = 'coordinates';

  @override
  LatLng getCoordinates() {
    var box = GetStorage();
    var result = LatLng(0, 0);

    if (box.hasData(_keyCoordinates)) {
      var receivedJson = box.read(_keyCoordinates);
      Map<String, dynamic> jsondatas = jsonDecode(receivedJson);
      result = LatLngSerialiser().fromJson(jsondatas);
    }

    return result;
  }

  @override
  void saveCoordinates(LatLng coordinates) {
    var box = GetStorage();
    box.write(
        _keyCoordinates, jsonEncode(LatLngSerialiser().toJson(coordinates)));
  }
}
