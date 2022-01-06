import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../../applications/map/application/port/in/get_store_location_query.dart';
import '../../../../../applications/map/application/service/get_store_location_service.dart';
import '../../../../../applications/map/domain/store_location.dart';
import '../../../../../common/message/messages.dart';
import '../../../../network/rest/map/remote_store_location_adatper.dart';
import '../../../../persistance/cached_coordinates_adapter.dart';
import '../../../../persistance/cached_store_location_adapter.dart';

class MapController extends SuperController {
  static const double initLatitude = 0;
  static const double initLongitude = 0;

  final Location _location = Location.instance;
  final RemoteConfig _remoteConfig = RemoteConfig.instance;

  final _key = 'kakao_api_key';
  final Rx<LatLng> cameraPosition = LatLng(initLatitude, initLongitude).obs;
  final mapMarkers = <Marker>{}.obs;
  final enableService = true.obs;

  final GetStoreLocationService getStoreLocationService =
      Get.find<GetStoreLocationService>();
  final RemoteStoreLocationAdapter remoteStoreLocationAdapter =
      Get.find<RemoteStoreLocationAdapter>();
  final CachedCoordinatesAdapter cachedCoordinatesAdapter =
      Get.find<CachedCoordinatesAdapter>();
  final CachedStoreLocationAdatper cachedStoreLocationAdatper =
      Get.find<CachedStoreLocationAdatper>();

  GoogleMapController? _mapController;
  StreamSubscription? _locationSubscription;

  bool _isUpdateLocationService = false;

  @override
  void onInit() {
    super.onInit();
    _initDatas();
  }

  void _initDatas() async {
    enableService(await _checkLocationService());

    if (enableService.value) {
      await _initCameraPosition();
      await _initializeRemoteConfig();
    }
  }

  Future<bool> _checkLocationService() async {
    var _serviceEnabled = await _location.serviceEnabled();
    var _permissionGranted = await _location.hasPermission();

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    return _serviceEnabled && _permissionGranted == PermissionStatus.granted;
  }

  Future<void> _initializeRemoteConfig() async {
    await _remoteConfig.setDefaults({_key: dotenv.env[_key]!});
    await _remoteConfig.fetchAndActivate();
  }

  Future<void> _initCameraPosition() async {
    if (enableService.value) {
      var locationData = await _location.getLocation();
      cameraPosition(LatLng(
        locationData.latitude!,
        locationData.longitude!,
      ));
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (_mapController != null) {
      _mapController!.dispose();
    }
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
    }
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    if (enableService.value) {
      _updateStoreLocation(
          latitude: cameraPosition.value.latitude,
          longitude: cameraPosition.value.longitude);
    }

    _location.changeSettings(interval: 3000, distanceFilter: 10.0);
    _locationSubscription = _location.onLocationChanged.listen(
      (locationData) async {
        if (_isChangedLocationData(
            current: LatLng(
              locationData.latitude!,
              locationData.longitude!,
            ),
            pre: cameraPosition.value)) {
          _mapController?.animateCamera(
            CameraUpdate.newLatLng(
                LatLng(locationData.latitude!, locationData.longitude!)),
          );

          _updateStoreLocation(
              latitude: locationData.latitude!,
              longitude: locationData.longitude!);

          cameraPosition(LatLng(
            locationData.latitude!,
            locationData.longitude!,
          ));
        }
      },
    );
  }

  bool _isChangedLocationData({required LatLng current, required LatLng pre}) {
    return current.longitude != pre.longitude ||
        current.latitude != pre.latitude;
  }

  void _updateStoreLocation(
      {required double latitude, required double longitude}) async {
    var preCoordinates = cachedCoordinatesAdapter.getCoordinates();
    var storeLocations =
        await getStoreLocationService.getStoreLocation(GetStoreLocationParam(
      preLatLng: preCoordinates,
      currentLatLng: LatLng(latitude, longitude),
      apiKey: _remoteConfig.getString(_key),
    ));

    storeLocations.fold(
        (failure) => Get.snackbar(
              Messages.shopLocationErrorTitle,
              Messages.shopLocationErrorMessage,
              snackPosition: SnackPosition.TOP,
            ), (datas) async {
      cachedCoordinatesAdapter.saveCoordinates(LatLng(latitude, longitude));
      cachedStoreLocationAdatper.saveStoreLocation(datas);

      mapMarkers.clear();
      mapMarkers.addAll(await _generateMarkers(datas));
    });
  }

  Future<List<Marker>> _generateMarkers(List<StoreLocation> datas) async {
    var results = <Marker>[];

    for (var data in datas) {
      var icon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(devicePixelRatio: 3.2), data.storeMarker!.uri);
      var marker = Marker(
        markerId: MarkerId(data.latLng.toString()),
        position: data.latLng,
        icon: icon,
      );
      results.add(marker);
    }

    return results;
  }

  bool get isLoadedLocationData {
    return cameraPosition.value.latitude != MapController.initLatitude ||
        cameraPosition.value.longitude != MapController.initLongitude;
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {
    _isUpdateLocationService = true;
  }

  @override
  void onResumed() {
    if (_isUpdateLocationService) {
      _initDatas();
      _isUpdateLocationService = false;
    }
  }
}
