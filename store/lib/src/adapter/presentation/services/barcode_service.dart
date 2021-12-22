import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../modules/barcode/model/mobile_carrier.dart';
import '../modules/barcode/model/mobile_carrier_type.dart';

class BarcodeService extends GetxService {
  static final defaultBarcode = '0000 0000 0000 0000';

  final RxInt selectedCarrierIndex = 0.obs;

  final carrierBarcodeMap = {
    MobileCarrierType.skt.name:
        ''.val(MobileCarrierType.skt.name, defVal: defaultBarcode),
    MobileCarrierType.kt.name:
        ''.val(MobileCarrierType.kt.name, defVal: defaultBarcode),
    MobileCarrierType.lguPlus.name:
        ''.val(MobileCarrierType.lguPlus.name, defVal: defaultBarcode),
  }.obs;

  String get selectedCarrierName =>
      mobileCarriers[selectedCarrierIndex.value].type.name;

  final List<MobileCarrier> mobileCarriers = [
    MobileCarrier(
      index: 0,
      type: MobileCarrierType.skt,
    ),
    MobileCarrier(
      index: 1,
      type: MobileCarrierType.kt,
    ),
    MobileCarrier(
      index: 2,
      type: MobileCarrierType.lguPlus,
    ),
  ];

  late final TextEditingController textEditingController;

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();

    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));

    initTextField();
  }

  void initTextField() {
    var barcode = carrierBarcodeMap[selectedCarrierName]!.val;
    textEditingController.text =
        BarcodeService.defaultBarcode == barcode ? '' : barcode;
  }

  @override
  void onClose() {
    textEditingController.dispose();
  }
}
