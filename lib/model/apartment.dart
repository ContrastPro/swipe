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

  // .cast<String>()
  ApartmentBuilder.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        ownerUID = map["ownerUID"],
        address = map["address"],
        apartmentComplex = map["apartmentComplex"],
        foundingDocument = map["foundingDocument"],
        appointmentApartment = map["appointmentApartment"],
        numberOfRooms = map["numberOfRooms"],
        apartmentLayout = map["apartmentLayout"],
        apartmentCondition = map["apartmentCondition"],
        totalArea = map["totalArea"],
        kitchenArea = map["kitchenArea"],
        balconyLoggia = map["balconyLoggia"],
        heatingType = map["heatingType"],
        typeOfPayment = map["typeOfPayment"],
        agentCommission = map["agentCommission"],
        communicationMethod = map["communicationMethod"],
        description = map["description"],
        price = map["price"],
        images = List<String>.from(map["images"]),
        promotionBuilder = PromotionBuilder.fromMap(map["promotion"]),
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

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
        '\n>> createdAt: ${createdAt?.toDate()}'
        '\n>> updatedAt: ${updatedAt?.toDate()}'
        '\n********************************\n';
  }
}

class Apartment {
  final String id;
  final String ownerUID;
  final String address;
  final String apartmentComplex;
  final String foundingDocument;
  final String appointmentApartment;
  final String numberOfRooms;
  final String apartmentLayout;
  final String apartmentCondition;
  final String totalArea;
  final String kitchenArea;
  final String balconyLoggia;
  final String heatingType;
  final String typeOfPayment;
  final String agentCommission;
  final String communicationMethod;
  final String description;
  final String price;
  final List<String> images;
  final Promotion promotion;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Apartment({@required ApartmentBuilder apartmentBuilder})
      : id = apartmentBuilder.id,
        ownerUID = apartmentBuilder.ownerUID,
        address = apartmentBuilder.address ?? "р-н Центральный ул. Темерязева",
        apartmentComplex = apartmentBuilder.apartmentComplex,
        foundingDocument = apartmentBuilder.foundingDocument,
        appointmentApartment = apartmentBuilder.appointmentApartment,
        numberOfRooms = apartmentBuilder.numberOfRooms,
        apartmentLayout = apartmentBuilder.apartmentLayout,
        apartmentCondition = apartmentBuilder.apartmentCondition,
        totalArea = apartmentBuilder.totalArea,
        kitchenArea = apartmentBuilder.kitchenArea,
        balconyLoggia = apartmentBuilder.balconyLoggia,
        heatingType = apartmentBuilder.heatingType,
        typeOfPayment = apartmentBuilder.typeOfPayment,
        agentCommission = apartmentBuilder.agentCommission,
        communicationMethod = apartmentBuilder.communicationMethod,
        description = apartmentBuilder.description ??
            "Особенная квартира в одном из самых престижных и закрытых элитных домов - Diadema Club House. Крестовский остров. Собственная терраса 109 кв. м с газонным покрытием. Прямой вид на воду, Среднюю Невку. Высокие потолки 3,4 м. Панорамные окна. Свободная планировка. Теплые водяные полы в санузлах. 2 машиноместа в подземном паркинге. Жилой комплекс располагается на Крестовском острове - сложившейся локации элитной недвижимости.",
        price = apartmentBuilder.price,
        images = apartmentBuilder.images,
        promotion = Promotion(
          promotionBuilder: apartmentBuilder.promotionBuilder,
        ),
        createdAt = apartmentBuilder.createdAt,
        updatedAt = apartmentBuilder.updatedAt;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "ownerUID": ownerUID,
      "address": address,
      "apartmentComplex": apartmentComplex,
      "foundingDocument": foundingDocument,
      "appointmentApartment": appointmentApartment,
      "numberOfRooms": numberOfRooms,
      "apartmentLayout": apartmentLayout,
      "apartmentCondition": apartmentCondition,
      "totalArea": totalArea,
      "kitchenArea": kitchenArea,
      "balconyLoggia": balconyLoggia,
      "heatingType": heatingType,
      "typeOfPayment": typeOfPayment,
      "agentCommission": agentCommission,
      "communicationMethod": communicationMethod,
      "description": description,
      "price": price,
      "images": images,
      "promotion": promotion.toMap(),
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
