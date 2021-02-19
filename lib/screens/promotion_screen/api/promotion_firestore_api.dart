import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/apartment.dart';

class PromotionFirestoreAPI {
  PromotionFirestoreAPI._();

  static Future<void> uploadApartment({
    @required Apartment apartment,
  }) {
    final DocumentReference apartmentReference = FirebaseFirestore.instance
        .collection("Swipe")
        .doc("Database")
        .collection("Ads")
        .doc(apartment.id);

    return apartmentReference
        .set(apartment.toMap())
        .then((value) => print("Apartment Added"))
        .catchError((error) => print("Failed to add apartment: $error"));
  }

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
