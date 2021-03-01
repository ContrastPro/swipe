import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/current_location.dart';
import 'package:swipe/global/map_notifier.dart';

class MFCScreen extends StatefulWidget {
  @override
  _MFCScreenState createState() => _MFCScreenState();
}

class _MFCScreenState extends State<MFCScreen> {
  static const double latitude = 46.41;
  static const double longitude = 30.71;

  MapNotifier _mapNotifier;
  GoogleMapController _mapController;
  List<Marker> _markerList = List<Marker>();

  @override
  void initState() {
    _loadMarkers();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _loadMarkers() {
    _mapNotifier = Provider.of<MapNotifier>(context, listen: false);
    _markerList.add(
      Marker(
        markerId: MarkerId("MFC"),
        position: LatLng(latitude, longitude),
        icon: _mapNotifier.mfcIcon,
      ),
    );
  }

  void _updateUserLocation() async {
    await _mapNotifier.loadUserLocation();
    if (_mapNotifier.userLocation != null) {
      if (!_markerList.contains(_mapNotifier.userMarker)) {
        setState(() {
          _markerList.add(_mapNotifier.userMarker);
        });
      }
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _mapNotifier.userLocation,
            zoom: 16.0,
          ),
        ),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    _mapController.setMapStyle(_mapNotifier.mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "МФЦ",
        onTapAction: () => Navigator.pop(context),
        onTapLeading: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 15.0,
            ),
            markers: Set.from(_markerList),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: CurrentLocation(
              isLocated:
                  _markerList.contains(_mapNotifier.userMarker) ? true : false,
              onTap: () => _updateUserLocation(),
            ),
          )
        ],
      ),
    );
  }
}
