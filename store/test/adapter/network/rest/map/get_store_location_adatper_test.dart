import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store/src/adapters/network/rest/map/get_store_location_adatper.dart';

void main() {
  test('면목역 근처 편의점 정보 가져오기', () async {
    var getStoreLocationAdapter = GetStoreLocationAdapter(Dio());
    var storeLocations =
        await getStoreLocationAdapter.getStoreLocations(127.0875, 37.5887);

    expect(storeLocations.value.length, 13);
  });
}
