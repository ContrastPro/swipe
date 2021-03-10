import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/model/building.dart';

class UserBuilder {
  // Personal User information
  String uid;
  String name;
  String lastName;
  String phone;
  String email;
  String photoURL;
  List notification;
  Timestamp createdAt;
  Timestamp updatedAt;

  // Information about User agent
  String agentName;
  String agentLastName;
  String agentPhone;
  String agentEmail;

  // ets
  bool isBanned;
  bool accessIsAllowed;
  BuildingBuilder buildingBuilder;

  UserBuilder();

  UserBuilder.fromMap(Map<String, dynamic> map)
      : uid = map["uid"],
        name = map["name"],
        lastName = map["lastName"],
        phone = map["phone"],
        email = map["email"],
        photoURL = map["photoURL"],
        notification = map["notification"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"],

        //
        agentName = map["agentName"],
        agentLastName = map["agentLastName"],
        agentPhone = map["agentPhone"],
        agentEmail = map["agentEmail"],
        //
        isBanned = map["isBanned"],
        accessIsAllowed = map["accessIsAllowed"],
        buildingBuilder = map["building"] != null
            ? BuildingBuilder.fromMap(map["building"])
            : null;

  UserBuilder._createClone(UserBuilder userBuilder)
      : uid = userBuilder.uid,
        name = userBuilder.name,
        lastName = userBuilder.lastName,
        phone = userBuilder.phone,
        email = userBuilder.email,
        photoURL = userBuilder.photoURL,
        notification = userBuilder.notification,
        createdAt = userBuilder.createdAt,
        updatedAt = userBuilder.updatedAt,

        //
        agentName = userBuilder.agentName,
        agentLastName = userBuilder.agentLastName,
        agentPhone = userBuilder.agentPhone,
        agentEmail = userBuilder.agentEmail,

        //
        isBanned = userBuilder.isBanned,
        accessIsAllowed = userBuilder.accessIsAllowed,
        buildingBuilder = userBuilder.buildingBuilder;

  UserBuilder clone() => UserBuilder._createClone(this);

  @override
  String toString() {
    return '\n********************************\n'
        '--- UserBuilder ---'
        '\n>> uid: $uid'
        '\n>> name: $name'
        '\n>> lastName: $lastName'
        '\n>> phone: $phone'
        '\n>> email: $email'
        '\n>> photoURL: $photoURL'
        '\n>> notification: $notification'
        '\n>> createdAt: ${createdAt?.toDate()}'
        '\n>> updatedAt: ${updatedAt?.toDate()}'

        //
        '\n>> agentName: $agentName'
        '\n>> agentLastName: $agentLastName'
        '\n>> agentPhone: $agentPhone'
        '\n>> agentEmail: $agentEmail'

        //
        '\n>> isBanned: $isBanned'
        '\n>> accessIsAllowed: $accessIsAllowed'
        '\n>> buildingBuilder: ${buildingBuilder != null}'
        '\n********************************\n';
  }
}

class CustomUser {
  // Personal User information
  final String uid;
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final String photoURL;
  final List notification;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  // Information about User agent
  final String agentName;
  final String agentLastName;
  final String agentPhone;
  final String agentEmail;

  // ets
  final bool isBanned;
  final bool accessIsAllowed;
  final Building building;

  CustomUser(UserBuilder userBuilder)
      : uid = userBuilder.uid,
        name = userBuilder.name,
        lastName = userBuilder.lastName,
        phone = userBuilder.phone,
        email = userBuilder.email?.toLowerCase(),
        photoURL = userBuilder.photoURL,
        notification = userBuilder.buildingBuilder == null
            ? userBuilder.notification ?? [true, false, false, false]
            : null,
        createdAt = userBuilder.createdAt,
        updatedAt = userBuilder.updatedAt,

        //
        agentName = userBuilder.agentName,
        agentLastName = userBuilder.agentLastName,
        agentPhone = userBuilder.agentPhone,
        agentEmail = userBuilder.agentEmail?.toLowerCase(),

        //
        isBanned = userBuilder.isBanned ?? false,
        accessIsAllowed = userBuilder.accessIsAllowed,
        building = userBuilder.buildingBuilder != null
            ? Building(userBuilder.buildingBuilder)
            : null;

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "email": email,
      "photoURL": photoURL,
      "notification": notification,
      "createdAt": createdAt,
      "updatedAt": updatedAt,

      //
      "agentName": agentName,
      "agentLastName": agentLastName,
      "agentPhone": agentPhone,
      "agentEmail": agentEmail,

      //
      "isBanned": isBanned,
      "accessIsAllowed": accessIsAllowed,
      "building": building?.toMap(),
    };
  }
}
