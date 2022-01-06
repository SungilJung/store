import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return _getChild();
    } else {
      return BackButtonListener(
        onBackButtonPressed: () {
          if (GetPlatform.isAndroid) {
            SystemNavigator.pop();
          }
          return Future.value(false);
        },
        child: _getChild(),
      );
    }
  }

  Container _getChild() {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text('홈'),
      ),
    );
  }
}
