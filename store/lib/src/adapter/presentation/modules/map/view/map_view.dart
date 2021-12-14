import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Center(
        child: Text('맵'),
      ),
    );
  }
}
