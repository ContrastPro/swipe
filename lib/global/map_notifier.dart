import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapNotifier with ChangeNotifier {
  BitmapDescriptor _mapIcon;
  BitmapDescriptor get mapIcon => _mapIcon;


  void setMapIcon() async {
    _mapIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/map_icon.png",
    );
    notifyListeners();
  }
}
