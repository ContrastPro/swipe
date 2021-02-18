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
    return '\n********************************\n'
        '--- ApartmentBuilder ---'
        '\n>> id: $id'
        '\n>> ownerUID: $ownerUID'
        '\n>> address: $address'
        '\n>> apartmentComplex: $apartmentComplex'
        '\n>> foundingDocument: $foundingDocument'
        '\n>> appointmentApartment: $appointmentApartment'
        '\n>> numberOfRooms: $numberOfRooms'
        '\n>> apartmentLayout: $apartmentLayout'
        '\n>> apartmentCondition: $apartmentCondition'
        '\n>> totalArea: $totalArea'
        '\n>> kitchenArea: $kitchenArea'
        '\n>> balconyLoggia: $balconyLoggia'
        '\n>> heatingType: $heatingType'
        '\n>> typeOfPayment: $typeOfPayment'
        '\n>> agentCommission: $agentCommission'
        '\n>> communicationMethod: $communicationMethod'
        '\n>> description: $description'
        '\n>> price: $price'
        '\n>> images: $images'
        '\n>> promotionBuilder: $promotionBuilder'
        '\n>> createdAt: $createdAt'
        '\n>> updatedAt: $updatedAt'
        '\n********************************\n';
  }
}

class Apartment {
  final Promotion promotion;

  Apartment({@required PromotionBuilder promotionBuilder})
      : promotion = Promotion(promotionBuilder: promotionBuilder);
}
