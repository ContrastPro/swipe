import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/apartment_screen/apartment_screen.dart';

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
  List<Marker> _markerList = List<Marker>();

  @override
  void initState() {
    _addMarkers();
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

  void _addMarkers() {
    for (int i = 0; i < widget.apartmentList.length; i++) {
      _markerList.add(
        Marker(
          markerId: MarkerId(widget.apartmentList[i].id),
          position: LatLng(
            widget.apartmentList[i].geo.latitude,
            widget.apartmentList[i].geo.longitude,
          ),
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
      );
    }

    /*widget.apartmentList.forEach((apartment) {
      _markerList.add(
        Marker(
          markerId: MarkerId(apartment.id),
          position: LatLng(
            apartment.geo.latitude,
            apartment.geo.longitude,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return ApartmentDetailDialog(
                  apartmentBuilder: apartment,
                  onTap: (){
                    log("${widget.apartmentList.indexOf(apartment)}");
                  },
                  */ /*onTap: () => _goToApartmentScreen(
                    widget.apartmentList.indexOf(apartment),
                  ),*/ /*
                );
              },
            );
          },
        ),
      );
    });*/
  }

  void _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(
      await DefaultAssetBundle.of(context).loadString(
        "assets/map/map_style.json",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      //zoomControlsEnabled: false,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(46.47747, 30.73262),
        zoom: 15.0,
      ),
      markers: Set.from(_markerList),
    );
  }
}
