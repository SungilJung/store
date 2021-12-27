import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapController extends GetxController {
  static const double initLatitude = 0;
  static const double initLongitude = 0;
  final Rx<LatLng> cameraPosition = LatLng(initLatitude, initLongitude).obs;
  final double defaultZoom = 17;

  LocationData? _preLocationData;
  GoogleMapController? _mapController;

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    Location.instance.onLocationChanged.listen(
      (locationData) async {
        if (_preLocationData == null ||
            locationData.latitude != _preLocationData!.latitude &&
                locationData.longitude != _preLocationData!.longitude) {
          var zoomLevel = await _mapController?.getZoomLevel() ?? defaultZoom;
          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(locationData.latitude!, locationData.longitude!),
                zoom: zoomLevel,
              ),
            ),
          );
          _preLocationData = locationData;
        }
      },
    );
    Location.instance.changeNotificationOptions();
  }

  void initCameraPosition() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await Location.instance.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await Location.instance.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await Location.instance.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await Location.instance.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var _locationData = await Location.instance.getLocation();
    cameraPosition(LatLng(_locationData.latitude!, _locationData.longitude!));
  }

  bool get isLoadedLocationData {
    return cameraPosition.value.latitude != MapController.initLatitude ||
        cameraPosition.value.longitude != MapController.initLongitude;
  }

  @override
  void onInit() {
    super.onInit();
    initCameraPosition();
  }

  @override
  void onClose() {
    _mapController = null;
  }
}
