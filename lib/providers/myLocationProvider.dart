import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyLocationProvider with ChangeNotifier {
  LocationData _myPosition;

  set setMyPosition(LocationData pos) {
    _myPosition = pos;
  }

  LocationData get getMyPosition {
    return _myPosition;
  }

  get getMyCameraPosition {
    return CameraPosition(
        target: LatLng(_myPosition.latitude, _myPosition.longitude),
        zoom: 14.4746);
  }
}
