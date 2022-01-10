import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proj4dart/proj4dart.dart';

class CoordinatesUtil {
  //EPSG:3857
  static const googleDef =
      '''+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs''';

  //EPSG:5181
  static const kakaoDef =
      '''+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs''';

  CoordinatesUtil._();

  static LatLng transformKakaoToGoogle({
    required double longitude,
    required double latitude,
  }) {
    var pointSrc = Point(x: latitude, y: longitude);
    var projSrc = Projection.parse(kakaoDef);
    var projDst = Projection.parse(googleDef);
    var pointForward = projSrc.transform(projDst, pointSrc);
    var pointInverse = projDst.transform(projSrc, pointForward);

    return LatLng(pointInverse.y - 0.00005, pointInverse.x - 0.00002);
  }
}
