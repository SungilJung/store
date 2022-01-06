import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../applications/map/application/port/out/get_remote_store_location_port.dart';
import '../../../../common/wrapper/value_wrapper.dart';
import 'model/store_location_model.dart';

part 'remote_store_location_adatper.g.dart';

ValueWrapper<T> deserializeValueWrapper<T extends List<StoreLocationModel>>(
    Map<String, dynamic> json) {
  List documents = json['documents'];

  var list = documents
      .map((e) => StoreLocationModel.fromJson(e as Map<String, dynamic>))
      .where((element) => element.storeMarker != null)
      .toList();

  return ValueWrapper(value: list as T);
}

@RestApi(
  baseUrl: 'https://dapi.kakao.com',
  parser: Parser.FlutterCompute,
)
abstract class RemoteStoreLocationAdapter
    with GetRemoteStoreLocationPort<StoreLocationModel> {
  factory RemoteStoreLocationAdapter(Dio dio, {String? baseUrl}) =
      _RemoteStoreLocationAdapter;

  @GET(
      '/v2/local/search/category.json?category_group_code=CS2&page=1&sort=distance&size=15')
  @override
  Future<ValueWrapper<List<StoreLocationModel>>> getStoreLocations(
      @Query("x") double x, @Query("y") double y,
      {@Query('radius') int radius = 1000,
      @Header('Authorization') required String apiKey});
}
