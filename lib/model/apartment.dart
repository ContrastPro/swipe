import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/promotion.dart';

class ApartmentBuilder {
  String id;
  String ownerUID;
  String address;
  String apartmentComplex;
  String foundingDocument;
  String appointmentApartment;
  String numberOfRooms;
  String apartmentLayout;
  String apartmentCondition;
  String totalArea;
  String kitchenArea;
  String balconyLoggia;
  String heatingType;
  String typeOfPayment;
  String agentCommission;
  String communicationMethod;
  String description;
  String price;
  List<String> images;
  PromotionBuilder promotionBuilder;

  Timestamp createdAt;
  Timestamp updatedAt;

  ApartmentBuilder();

  @override
  String toString() {
    return 'ApartmentBuilder $price \n $promotionBuilder';
  }
}

class Apartment {
  final Promotion promotion;

  Apartment({@required PromotionBuilder promotionBuilder})
      : promotion = Promotion(promotionBuilder: promotionBuilder);
}
