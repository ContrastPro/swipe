import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapNotifier with ChangeNotifier {
  // Private
  String _mapStyle;

  BitmapDescriptor _adMapIcon;

  BitmapDescriptor _adMapOwnerIcon;

  BitmapDescriptor _userIcon;

  BitmapDescriptor _mfcIcon;

  Marker _userMarker;

  LatLng _initialLocation = LatLng(46.48, 30.73);

  LatLng _userLocation;

  Location _locationTracker = Location();

  // Getters
  String get mapStyle => _mapStyle;

  BitmapDescriptor get adMapIcon => _adMapIcon;

  BitmapDescriptor get adMapOwnerIcon => _adMapOwnerIcon;

  BitmapDescriptor get mfcIcon => _mfcIcon;

  Marker get userMarker => _userMarker;

  LatLng get initialLocation => _initialLocation;

  LatLng get userLocation => _userLocation;

  void mapInitialize() {
    _loadMapStyle();
    _loadMapIcon();
    _loadMapOwnerIcon();
    _loadUserIcon();
    _loadMFCIcon();
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

  void _loadMapOwnerIcon() async {
    _adMapOwnerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/owner_icon.png",
    );
  }

  void _loadUserIcon() async {
    _userIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/user_icon.png",
    );
  }

  void _loadMFCIcon() async {
    _mfcIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/mfc_icon.png",
    );
  }
}
