import 'store_marker.dart';

enum StoreType {
  cu,
  gs25,
  sevenEleven,
  emart24,
  ministop,
}

extension StoreTypeExtension on StoreType {
  static const names = {
    StoreType.cu: 'CU',
    StoreType.gs25: 'GS25',
    StoreType.sevenEleven: '세븐일레븐',
    StoreType.emart24: '이마트24',
    StoreType.ministop: '미니스톱',
  };
  static const markers = {
    StoreType.cu: StoreMarker('assets/store/marker/cu.png'),
    StoreType.gs25: StoreMarker('assets/store/marker/gs.png'),
    StoreType.sevenEleven: StoreMarker('assets/store/marker/7eleven.png'),
    StoreType.emart24: StoreMarker('assets/store/marker/emart.png'),
    StoreType.ministop: StoreMarker('assets/store/marker/ministop.png'),
  };

  StoreMarker? get marker => markers[this];

  String? get name => names[this];
}
