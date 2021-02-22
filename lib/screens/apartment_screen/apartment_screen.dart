import 'package:flutter/material.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/model/custom_user.dart';

import 'api/apartment_firestore_api.dart';
import 'custom_widget/apartment_widget.dart';

class ApartmentScreen extends StatelessWidget {
  final ApartmentBuilder apartmentBuilder;

  const ApartmentScreen({
    Key key,
    @required this.apartmentBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserBuilder>(
      future: ApartmentFirestoreAPI.getOwnerProfile(
        ownerUID: apartmentBuilder.ownerUID,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ApartmentWidget(
            apartmentBuilder: apartmentBuilder,
            userBuilder: snapshot.data,
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
