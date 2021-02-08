import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserBuilder {
  String uid;
  String name;
  String lastName;
  String phone;
  String email;
  String photoURL;
  Timestamp createdAt;
  Timestamp updatedAt;

  //
  String agentName;
  String agentLastName;
  String agentPhone;
  String agentEmail;

  //
  List notification;

  UserBuilder();

  UserBuilder.fromMap(Map<String, dynamic> map)
      : uid = map["uid"],
        name = map["name"],
        lastName = map["lastName"],
        phone = map["phone"],
        email = map["email"],
        photoURL = map["photoURL"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"],

        //
        agentName = map["agentName"],
        agentLastName = map["agentLastName"],
        agentPhone = map["agentPhone"],
        agentEmail = map["agentEmail"],
        //
        notification = map["notification"];

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
        '\n>> createdAt: $createdAt'
        '\n>> updatedAt: $updatedAt'

        //
        '\n>> agentName: $agentName'
        '\n>> agentLastName: $agentLastName'
        '\n>> agentPhone: $agentPhone'
        '\n>> agentEmail: $agentEmail'

        //
        '\n>> notification: $notification'
        '\n********************************\n';
  }
}

class CustomUser {
  final String uid;
  final String name;
  final String lastName;
  final String phone;
  final String email;
  final String photoURL;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  //
  final String agentName;
  final String agentLastName;
  final String agentPhone;
  final String agentEmail;

  //
  final List notification;

  CustomUser({@required UserBuilder builder})
      : uid = builder.uid,
        name = builder.name,
        lastName = builder.lastName,
        phone = builder.phone,
        email = builder.email,
        photoURL = builder.photoURL,
        createdAt = builder.createdAt,
        updatedAt = builder.updatedAt,

        //
        agentName = builder.agentName,
        agentLastName = builder.agentLastName,
        agentPhone = builder.agentPhone,
        agentEmail = builder.agentEmail,

        //
        notification = builder.notification;

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "email": email?.toLowerCase(),
      "photoURL": photoURL,
      "createdAt": createdAt,
      "updatedAt": updatedAt,

      //
      "agentName": agentName,
      "agentLastName": agentLastName,
      "agentPhone": agentPhone,
      "agentEmail": agentEmail?.toLowerCase(),

      //
      "notification": notification ?? [true, false, false, false],
    };
  }
}
