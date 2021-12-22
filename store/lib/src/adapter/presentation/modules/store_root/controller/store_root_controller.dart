import 'dart:async';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class StoreRootController extends GetxController {
  final RxBool showBarcode = false.obs;
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
}
