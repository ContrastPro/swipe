import 'package:cloud_firestore/cloud_firestore.dart';

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


  Timestamp createdAt;
  Timestamp updatedAt;

  @override
  String toString() {
    return 'ApartmentBuilder{'
        'id: $id, '
        'ownerUID: $ownerUID, '
        'address: $address, '
        'apartmentComplex: $apartmentComplex, '
        'foundingDocument: $foundingDocument, '
        'appointmentApartment: $appointmentApartment, '
        'numberOfRooms: $numberOfRooms, '
        'apartmentLayout: $apartmentLayout, '
        'apartmentCondition: $apartmentCondition, '
        'totalArea: $totalArea, '
        'kitchenArea: $kitchenArea, '
        'balconyLoggia: $balconyLoggia, '
        'heatingType: $heatingType, '
        'typeOfPayment: $typeOfPayment, '
        'agentCommission: $agentCommission, '
        'communicationMethod: $communicationMethod, '
        'description: $description, '
        'price: $price, '
        'images: $images, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt}';
  }
}
