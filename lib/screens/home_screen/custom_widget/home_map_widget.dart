import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/current_location.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/global/map_notifier.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/apartment_screen/apartment_screen.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

import 'items_list_widget/apartment_detail_dialog.dart';

class HomeMapWidget extends StatefulWidget {
  final List<DocumentSnapshot> documentList;
  final List<ApartmentBuilder> apartmentList;

  const HomeMapWidget({
    Key key,
    @required this.documentList,
    @required this.apartmentList,
  }) : super(key: key);

  @override
  _HomeMapWidgetState createState() => _HomeMapWidgetState();
}

class _HomeMapWidgetState extends State<HomeMapWidget> {
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

  void _goToApartmentScreen(int index) {
    Navigator.push(
      context,
      FadeRoute(
        page: ApartmentScreen(
          apartmentBuilder: ApartmentBuilder.fromMap(
            widget.documentList[index].data(),
          ),
        ),
      ),
    );
  }

  bool _isOwner(int index) {
    return _user.uid == widget.apartmentList[index].ownerUID;
  }

  void _loadMarkers() {
    _mapNotifier = Provider.of<MapNotifier>(context, listen: false);
    for (int i = 0; i < widget.apartmentList.length; i++) {
      _markerList.add(
        Marker(
          markerId: MarkerId(widget.apartmentList[i].id),
          position: LatLng(
            widget.apartmentList[i].geo.latitude,
            widget.apartmentList[i].geo.longitude,
          ),
          icon: _isOwner(i)
              ? _mapNotifier.adMapOwnerIcon
              : _mapNotifier.adMapIcon,
          infoWindow: InfoWindow(
            title: "${widget.apartmentList[i].price} ₽",
            snippet: widget.apartmentList[i].address,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ApartmentDetailDialog(
                    apartmentBuilder: widget.apartmentList[i],
                    onTap: () => _goToApartmentScreen(i),
                  );
                },
              );
            },
          ),
        ),
      );
    }
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
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: false,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _mapNotifier.initialLocation,
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
    );
  }
}
