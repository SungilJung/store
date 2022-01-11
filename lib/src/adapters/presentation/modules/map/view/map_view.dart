import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/message/messages.dart';
import '../controller/map_controller.dart';

class MapView extends GetView<MapController> {
  final double _defaultZoom = 17;

  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          fit: StackFit.expand,
          children: [
            if (controller.enableService.value &&
                !controller.isLoadedLocationData)
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
                  zoom: _defaultZoom,
                ),
                myLocationEnabled: true,
                onMapCreated: (mapController) =>
                    controller.onMapCreated(mapController),
                markers: controller.mapMarkers,
              ),
            Visibility(
                visible: !controller.enableService.value,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Messages.locationServiceError,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: AppSettings.openLocationSettings,
                        child: Text(Messages.openSettings),
                      ),
                    ],
                  ),
                ))
          ],
        );
      },
    );
  }
}
