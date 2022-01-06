import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store/src/adapters/network/rest/map/remote_store_location_adatper.dart';

void main() {
  setUpAll(() async {
    dotenv.testLoad(fileInput: File('test/.env').readAsStringSync());
  });
  test('면목역 근처 편의점 정보 가져오기', () async {
    var getStoreLocationAdapter = RemoteStoreLocationAdapter(Dio());
    var storeLocations = await getStoreLocationAdapter.getStoreLocations(
      127.0875,
      37.5887,
      apiKey: dotenv.env['kakao_api_key']!,
    );

    expect(storeLocations.value.length, 13);
  });
}
