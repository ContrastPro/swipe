import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapNotifier with ChangeNotifier {
  BitmapDescriptor _mapIcon;

  BitmapDescriptor get mapIcon => _mapIcon;

  String _mapStyle;

  String get mapStyle => _mapStyle;

  void mapInitialize() {
    _loadMapStyle();
    _loadMapIcon();
    notifyListeners();
  }

  void _loadMapStyle() async {
    _mapStyle = await rootBundle.loadString(
      "assets/map/map_style.json",
    );
  }

  void _loadMapIcon() async {
    _mapIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/map_icon.png",
    );
  }
}
