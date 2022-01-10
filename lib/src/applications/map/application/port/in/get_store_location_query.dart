import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/error/failures.dart';
import '../../../domain/store_location.dart';

abstract class GetStoreLocationQuery {
  Future<Either<Failure, List<StoreLocation>>> getStoreLocation(
      GetStoreLocationParam command);
}

class GetStoreLocationParam {
  static const int defaultRadius = 1000;

  final LatLng preLatLng;
  final LatLng currentLatLng;
  final int radius;
  final String apiKey;

  GetStoreLocationParam({
    required this.preLatLng,
    required this.currentLatLng,
    required this.apiKey,
    this.radius = defaultRadius,
  });
}
