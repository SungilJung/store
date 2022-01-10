import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'serialiser/lat_lng_serialiser.dart';
import 'store_marker.dart';

part 'store_location.g.dart';

@JsonSerializable()
class StoreLocation {
  @LatLngSerialiser()
  final LatLng latLng;
  final StoreMarker? storeMarker;

  StoreLocation({
    required this.latLng,
    required this.storeMarker,
  });

  factory StoreLocation.fromJson(Map<String, dynamic> json) =>
      _$StoreLocationFromJson(json);

  Map<String, dynamic> toJson() => _$StoreLocationToJson(this);
}
