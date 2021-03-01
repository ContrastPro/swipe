import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/current_location.dart';
import 'package:swipe/global/map_notifier.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

class ShowOnMapScreen extends StatefulWidget {
  final ApartmentBuilder apartmentBuilder;

  const ShowOnMapScreen({
    Key key,
    this.apartmentBuilder,
  }) : super(key: key);

  @override
  _ShowOnMapScreenState createState() => _ShowOnMapScreenState();
}

class _ShowOnMapScreenState extends State<ShowOnMapScreen> {
  User _user;
  MapNotifier _mapNotifier;
  GoogleMapController _mapController;
  List<Marker> _markerList = List<Marker>();

  @override
  void initState() {
    _user = AuthFirebaseAPI.getCurrentUser();
    _loadMarkers();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  bool _isOwner() {
    return _user.uid == widget.apartmentBuilder.ownerUID;
  }

  void _loadMarkers() {
    _mapNotifier = Provider.of<MapNotifier>(context, listen: false);
    _markerList.add(
      Marker(
        markerId: MarkerId(widget.apartmentBuilder.id),
        position: LatLng(
          widget.apartmentBuilder.geo.latitude,
          widget.apartmentBuilder.geo.longitude,
        ),
        icon: _isOwner() ? _mapNotifier.adMapOwnerIcon : _mapNotifier.adMapIcon,
        infoWindow: InfoWindow(
          title: "${widget.apartmentBuilder.price} ₽",
          snippet: widget.apartmentBuilder.address,
          onTap: () => Navigator.pop(context),
        ),
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
        title: "Объявление на карте",
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
              target: LatLng(
                widget.apartmentBuilder.geo.latitude,
                widget.apartmentBuilder.geo.longitude,
              ),
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
