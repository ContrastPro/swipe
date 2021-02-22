import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/apartment.dart';

class ApartmentEditFirestoreAPI {
  ApartmentEditFirestoreAPI._();

  static Future<void> updateApartment({
    @required Apartment apartment,
  }) {
    final DocumentReference apartmentReference = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Ads")
        .doc(apartment.id);

    return apartmentReference
        .update(apartment.toMap())
        .then((value) => print("Apartment Updated"))
        .catchError((error) => print("Failed to update apartment: $error"));
  }



}
