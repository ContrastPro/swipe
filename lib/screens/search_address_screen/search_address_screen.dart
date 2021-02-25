import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/fab/apartment_fab_edit.dart';
import 'package:swipe/model/address.dart';

import 'custom_widget/text_field_search_address.dart';

class SearchAddressScreen extends StatefulWidget {
  @override
  _SearchAddressScreenState createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  AddressBuilder _addressBuilder;

  @override
  void initState() {
    _addressBuilder = AddressBuilder();
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) async {
    controller.setMapStyle(
      await DefaultAssetBundle.of(context).loadString(
        "assets/map/map_style.json",
      ),
    );
  }

  void _getAddress() {
    String latitude = "46.${Random().nextInt(9999) + 100}";
    String longitude = "30.${Random().nextInt(9999) + 100}";

    _addressBuilder.address = "р-н Центральный ул. Темерязева";
    _addressBuilder.geo = GeoPoint(
      double.parse(latitude),
      double.parse(longitude),
    );
    Navigator.pop(context, _addressBuilder);
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
            height: 85,
            alignment: Alignment.center,
            child: TextFieldSearchAddress(
              hintText: "Адрес",
              onChanged: (String value){},
            ),
          ),
          Expanded(
            child: GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(46.47747, 30.73262),
                zoom: 15.0,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ApartmentFABEdit(
        title: "Подтвердить адрес",
        onTap: () => _getAddress(),
      ),
    );
  }
}
