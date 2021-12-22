enum MobileCarrierType { skt, kt, lguPlus }

extension MobileCarrierTypeExtension on MobileCarrierType {
  static const names = {
    MobileCarrierType.skt: 'SKT',
    MobileCarrierType.kt: 'KT',
    MobileCarrierType.lguPlus: 'LGU+',
  };

  String get name => names[this] ?? '';
}
