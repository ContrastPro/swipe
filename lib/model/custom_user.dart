import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/model/subscription.dart';

class UserBuilder {

  // Personal User information
  String uid;
  String name;
  String lastName;
  String phone;
  String email;
  String photoURL;
  Timestamp createdAt;
  Timestamp updatedAt;

  // Information about User agent
  String agentName;
  String agentLastName;
  String agentPhone;
  String agentEmail;

  // ets
  List notification;
  Subscription subscription;

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
        notification = map["notification"],
        subscription = Subscription.fromMap(map["subscription"]);

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
        '\n>> createdAt: ${createdAt?.toDate()}'
        '\n>> updatedAt: ${updatedAt?.toDate()}'

        //
        '\n>> agentName: $agentName'
        '\n>> agentLastName: $agentLastName'
        '\n>> agentPhone: $agentPhone'
        '\n>> agentEmail: $agentEmail'

        //
        '\n>> subscription: $subscription'
        '\n>> notification: $notification'
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
  final Timestamp createdAt;
  final Timestamp updatedAt;

  // Information about User agent
  final String agentName;
  final String agentLastName;
  final String agentPhone;
  final String agentEmail;

  // ets
  final List notification;
  final Subscription subscription;

  CustomUser({@required UserBuilder builder})
      : uid = builder.uid,
        name = builder.name,
        lastName = builder.lastName,
        phone = builder.phone,
        email = builder.email?.toLowerCase(),
        photoURL = builder.photoURL,
        createdAt = builder.createdAt,
        updatedAt = builder.updatedAt,

        //
        agentName = builder.agentName,
        agentLastName = builder.agentLastName,
        agentPhone = builder.agentPhone,
        agentEmail = builder.agentEmail?.toLowerCase(),

        //
        subscription = builder.subscription ?? Subscription(),
        notification = builder.notification ?? [true, false, false, false];

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "email": email,
      "photoURL": photoURL,
      "createdAt": createdAt,
      "updatedAt": updatedAt,

      //
      "agentName": agentName,
      "agentLastName": agentLastName,
      "agentPhone": agentPhone,
      "agentEmail": agentEmail,

      //
      "subscription": subscription.toMap(),
      "notification": notification,
    };
  }
}
