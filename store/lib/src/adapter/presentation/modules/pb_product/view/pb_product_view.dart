import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/pb_product_controller.dart';

class PbProductView extends GetView<PbProductController> {
  const PbProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Center(
        child: Text('pb상품'),
      ),
    );
  }
}
