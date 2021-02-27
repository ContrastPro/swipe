import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/fab/apartment_fab_edit.dart';
import 'package:swipe/global/map_notifier.dart';
import 'package:swipe/model/address.dart';

import 'custom_widget/text_field_search_address.dart';

class SearchAddressScreen extends StatefulWidget {
  @override
  _SearchAddressScreenState createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  double _latitude;
  double _longitude;
  MapNotifier _mapNotifier;
  AddressBuilder _addressBuilder;
  List<Marker> _markerList = List<Marker>();

  @override
  void initState() {
    _getAddress();
    super.initState();
  }

  void _getAddress() {
    _mapNotifier = Provider.of<MapNotifier>(context, listen: false);
    _addressBuilder = AddressBuilder();
    _latitude = double.parse("46.${Random().nextInt(9999) + 100}");
    _longitude = double.parse("30.${Random().nextInt(9999) + 100}");

    _addressBuilder.address = "р-н Центральный ул. Темерязева";
    _addressBuilder.geo = GeoPoint(_latitude, _longitude);

    _markerList.add(
      Marker(
        markerId: MarkerId(_addressBuilder.address),
        position: LatLng(_latitude, _longitude),
        icon: _mapNotifier.adMapIcon,
        draggable: true,
        onDragEnd: (LatLng positionParam) {
          _addressBuilder.geo = GeoPoint(
            positionParam.latitude,
            positionParam.longitude,
          );
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(_mapNotifier.mapStyle);
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_latitude, _longitude),
          zoom: 13.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Выбрать адрес",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          Container(
            height: 85.0,
            alignment: Alignment.center,
            child: TextFieldSearchAddress(
              hintText: "Адрес",
              onChanged: (String value) {},
            ),
          ),
          Expanded(
            child: GoogleMap(
              //zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _mapNotifier.initialLocation,
                zoom: 15.0,
              ),
              markers: Set.from(_markerList),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ApartmentFABEdit(
        title: "Подтвердить адрес",
        onTap: () => Navigator.pop(context, _addressBuilder),
      ),
    );
  }
}
