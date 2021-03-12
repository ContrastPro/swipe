import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/model/promotion.dart';

class BuildingBuilder {
  String id;
  String ownerUID;
  String address;
  String description;
  String status;
  String type;
  String buildingClass;
  String technology;
  String territory;
  String distanceToSea;
  String payments;
  String ceilingHeight;
  String gas;
  String heating;
  String sewerage;
  String waterSupply;
  String registration;
  String typeOfPayment;
  String appointmentApartment;
  String amountContract;

  //
  List<String> advantages;
  PromotionBuilder promotionBuilder;

  //
  GeoPoint geo;
  Timestamp createdAt;
  Timestamp updatedAt;

  BuildingBuilder();

  BuildingBuilder.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        ownerUID = map["ownerUID"],
        address = map["address"],
        description = map["description"],
        status = map["status"],
        type = map["type"],
        buildingClass = map["buildingClass"],
        technology = map["technology"],
        territory = map["territory"],
        distanceToSea = map["distanceToSea"],
        payments = map["payments"],
        ceilingHeight = map["ceilingHeight"],
        gas = map["gas"],
        heating = map["heating"],
        sewerage = map["sewerage"],
        waterSupply = map["waterSupply"],
        registration = map["registration"],
        typeOfPayment = map["typeOfPayment"],
        appointmentApartment = map["appointmentApartment"],
        amountContract = map["amountContract"],
        advantages = List<String>.from(map["advantages"]),
        promotionBuilder = PromotionBuilder.fromMap(map["promotion"]),

        //
        geo = map["geo"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return '\n********************************\n'
        '--- BuildingBuilder ---'
        '\n>> address: $address'
        '\n********************************\n';
  }
}

class Building {
  final String id;
  final String ownerUID;
  final String address;
  final String description;
  final String status;
  final String type;
  final String buildingClass;
  final String technology;
  final String territory;
  final String distanceToSea;
  final String payments;
  final String ceilingHeight;
  final String gas;
  final String heating;
  final String sewerage;
  final String waterSupply;
  final String registration;
  final String typeOfPayment;
  final String appointmentApartment;
  final String amountContract;

  //
  final List<String> advantages;
  final Promotion promotion;

  //
  final GeoPoint geo;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Building(BuildingBuilder buildingBuilder)
      : id = buildingBuilder.id,
        ownerUID = buildingBuilder.ownerUID,
        address = buildingBuilder.address,
        description = buildingBuilder.description,
        status = buildingBuilder.status,
        type = buildingBuilder.type,
        buildingClass = buildingBuilder.buildingClass,
        technology = buildingBuilder.technology,
        territory = buildingBuilder.territory,
        distanceToSea = buildingBuilder.distanceToSea,
        payments = buildingBuilder.payments,
        ceilingHeight = buildingBuilder.ceilingHeight,
        gas = buildingBuilder.gas,
        heating = buildingBuilder.heating,
        sewerage = buildingBuilder.sewerage,
        waterSupply = buildingBuilder.waterSupply,
        registration = buildingBuilder.registration,
        typeOfPayment = buildingBuilder.typeOfPayment,
        appointmentApartment = buildingBuilder.appointmentApartment,
        amountContract = buildingBuilder.amountContract,
        advantages = buildingBuilder.advantages,
        promotion = Promotion(buildingBuilder.promotionBuilder),

        //
        geo = buildingBuilder.geo,
        createdAt = buildingBuilder.createdAt,
        updatedAt = buildingBuilder.updatedAt;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "ownerUID": ownerUID,
      "address": address,
      "description": description,
      "status": status,
      "type": type,
      "buildingClass": buildingClass,
      "technology": technology,
      "territory": territory,
      "distanceToSea": distanceToSea,
      "payments": payments,
      "ceilingHeight": ceilingHeight,
      "gas": gas,
      "heating": heating,
      "sewerage": sewerage,
      "waterSupply": waterSupply,
      "registration": registration,
      "typeOfPayment": typeOfPayment,
      "appointmentApartment": appointmentApartment,
      "amountContract": amountContract,
      "advantages": advantages,
      "promotion": promotion.toMap(),

      //
      "geo": geo,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
