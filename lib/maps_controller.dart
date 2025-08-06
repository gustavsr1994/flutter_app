import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsController extends ChangeNotifier {
bool isLoading = false;
  LatLng? currentPosition;

  Future fetchCurrentPosition() async {
    isLoading = true;
    notifyListeners();

    bool serviceLocationEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceLocationEnable) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission is denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission is permantely denied');
    }
    var result = await Geolocator.getCurrentPosition();
    currentPosition = LatLng(result.latitude, result.longitude);
    isLoading = false;
    notifyListeners();
  }
}
