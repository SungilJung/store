import 'package:json_annotation/json_annotation.dart';

part 'store_marker.g.dart';

@JsonSerializable()
class StoreMarker {
  final String uri;

  const StoreMarker(this.uri);

  factory StoreMarker.fromJson(Map<String, dynamic> json) =>
      _$StoreMarkerFromJson(json);

  Map<String, dynamic> toJson() => _$StoreMarkerToJson(this);
}
