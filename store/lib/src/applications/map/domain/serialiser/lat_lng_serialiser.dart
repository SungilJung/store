import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

class LatLngSerialiser extends JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngSerialiser();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(json['latitude'], json['longitude']);
  }

  @override
  Map<String, dynamic> toJson(LatLng object) {
    return {
      'latitude': object.latitude,
      'longitude': object.longitude,
    };
  }
}
