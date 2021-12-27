import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../common/logger/logger_utils.dart';
import '../controller/map_controller.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          fit: StackFit.expand,
          children: [
            if (!controller.isLoadedLocationData)
              Container(
                child: Center(
                  child: SpinKitChasingDots(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            if (controller.isLoadedLocationData)
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.cameraPosition.value,
                  zoom: controller.defaultZoom,
                ),
                myLocationEnabled: true,
                onMapCreated: (mapController) =>
                    controller.onMapCreated(mapController),
              ),
            if (controller.isLoadedLocationData)
              Positioned(
                top: 0,
                right: GetPlatform.isAndroid ? 50 : 0,
                child: Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  width: 40 * (GetPlatform.isAndroid ? 1 : 1.5),
                  height: 40 * (GetPlatform.isAndroid ? 1 : 1.5),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: GetPlatform.isAndroid
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400]!.withOpacity(0.4),
                        blurRadius: 0.5,
                        spreadRadius: 0.0,
                        offset:
                            Offset(0.5, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: TextButton(
                    child: Icon(
                      Icons.store,
                      color: Colors.grey[700],
                    ),
                    style: TextButton.styleFrom(
                      shape: GetPlatform.isAndroid ? null : CircleBorder(),
                      primary: Colors.grey[300],
                    ),
                    onPressed: () {
                      Logger.logNoStack.d('touch');
                    },
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
