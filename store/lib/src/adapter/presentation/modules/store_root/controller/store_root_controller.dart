import 'dart:async';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../barcode/model/mobile_carrier.dart';

class StoreRootController extends GetxController {
  final RxBool showBarcode = false.obs;
  final RxInt selectedCarrierIndex = 0.obs;
  final RxBool _showBottomNavigator = true.obs;
  late final StreamSubscription<bool> _keyboardSubscription;

  @override
  void onInit() {
    super.onInit();
    var keyboardVisibilityController = KeyboardVisibilityController();
    _keyboardSubscription =
        keyboardVisibilityController.onChange.listen((visible) {
      _showBottomNavigator(!visible);
    });
  }

  @override
  void onClose() {
    _keyboardSubscription.cancel();
  }

  bool get showBottomNavigator => _showBottomNavigator.value;

  String get selectedCarrierName =>
      mobileCarriers[selectedCarrierIndex.value].name;

  final List<MobileCarrier> mobileCarriers = [
    MobileCarrier(
      index: 0,
      name: 'SKT',
    ),
    MobileCarrier(
      index: 1,
      name: 'KT',
    ),
    MobileCarrier(
      index: 2,
      name: 'LGU+',
    ),
  ];
}
