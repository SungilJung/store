import 'package:dartz/dartz.dart';

import '../../../../common/error/failures.dart';
import '../../domain/store_location.dart';
import '../../util/location_util.dart';
import '../port/in/get_store_location_query.dart';
import '../port/out/get_cached_store_location_port.dart';
import '../port/out/get_remote_store_location_port.dart';

class GetStoreLocationService extends GetStoreLocationQuery {
  static const int limitedRadius = 200;

  final GetCachedStoreLocationPort getCachedStoreLocationPort;
  final GetRemoteStoreLocationPort getRemoteStoreLocationPort;

  GetStoreLocationService({
    required this.getCachedStoreLocationPort,
    required this.getRemoteStoreLocationPort,
  });

  @override
  Future<Either<Failure, List<StoreLocation>>> getStoreLocation(
      GetStoreLocationParam param) async {
    var start = param.preLatLng;
    var end = param.currentLatLng;

    var distanceBetween = LocationUtil.distanceBetween(
        start.latitude, start.longitude, end.latitude, end.longitude);

    if (distanceBetween > limitedRadius) {
      var storeLocations = await getRemoteStoreLocationPort.getStoreLocations(
        param.currentLatLng.longitude,
        param.currentLatLng.latitude,
        radius: param.radius,
        apiKey: param.apiKey,
      );
      return Right(storeLocations.value);
    } else {
      return Right(getCachedStoreLocationPort.getStoreLocations());
    }
  }
}
