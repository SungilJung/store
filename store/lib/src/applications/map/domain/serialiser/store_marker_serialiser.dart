import 'package:json_annotation/json_annotation.dart';
import '../store_marker.dart';

class StoreMarkerSerialiser
    extends JsonConverter<StoreMarker, Map<String, dynamic>> {
  @override
  StoreMarker fromJson(Map<String, dynamic> json) {
    if ('category_name' == json.keys.first) {}
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson(StoreMarker object) {
    return {'uri': object.uri};
  }
}
