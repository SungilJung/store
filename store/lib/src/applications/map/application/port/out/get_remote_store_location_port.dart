import '../../../../../common/wrapper/value_wrapper.dart';
import '../../../domain/store_location.dart';

mixin GetRemoteStoreLocationPort<T extends StoreLocation> {
  Future<ValueWrapper<List<T>>> getStoreLocations(
    double x,
    double y, {
    int radius = 1000,
  });
}
