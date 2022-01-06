import '../../../../../applications/map/domain/store_location.dart';
import '../../../../../applications/map/domain/store_marker.dart';
import '../../../../../applications/map/domain/store_type.dart'
    show StoreType, StoreTypeExtension;
import '../util/coordinates_util.dart';

class StoreLocationModel extends StoreLocation {
  StoreLocationModel({
    required String categoryName,
    required double x,
    required double y,
  }) : super(
            latLng: CoordinatesUtil.transformKakaoToGoogle(
                longitude: y, latitude: x),
            storeMarker: _convert(categoryName));

  static StoreMarker? _convert(String categoryName) {
    var name =
        categoryName.substring(categoryName.lastIndexOf('> ') + 1).trim();

    var find = StoreType.values.where((element) => name == element.name!);
    return find.isNotEmpty ? find.first.marker : null;
  }

  factory StoreLocationModel.fromJson(Map<String, dynamic> json) =>
      StoreLocationModel(
        categoryName: json['category_name'] as String,
        x: double.parse(json['x']),
        y: double.parse(json['y']),
      );
}
