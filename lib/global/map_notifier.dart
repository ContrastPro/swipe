import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapNotifier with ChangeNotifier {
  String _mapStyle;

  BitmapDescriptor _adMapIcon;

  Marker _userMarker;

  LatLng _initialLocation = LatLng(46.48, 30.73);

  LatLng _userLocation;

  String get mapStyle => _mapStyle;

  BitmapDescriptor get adMapIcon => _adMapIcon;

  Marker get userMarker => _userMarker;

  LatLng get initialLocation => _initialLocation;

  LatLng get userLocation => _userLocation;

  // Private
  Location _locationTracker = Location();
  BitmapDescriptor _userIcon;

  void mapInitialize() {
    _loadMapStyle();
    _loadMapIcon();
    _loadUserIcon();
  }

  Future<void> loadUserLocation() async {
    try {
      LocationData locationData = await _locationTracker.getLocation();
      _userLocation = LatLng(
        locationData.latitude,
        locationData.longitude,
      );
      _userMarker = Marker(
        markerId: MarkerId("user"),
        position: _userLocation,
        icon: _userIcon,
      );
      notifyListeners();
    } catch (e) {
      log("$e");
    }
  }

  void _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString(
      "assets/map/map_style.json",
    );
  }

  void _loadMapIcon() async {
    _adMapIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/map_icon.png",
    );
  }

  void _loadUserIcon() async {
    _userIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/user_icon.png",
    );
  }
}
