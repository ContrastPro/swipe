import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserBuilder {
  String uid;
  String name;
  String lastName;
  String phone;
  String email;
  String photoURL;
  Timestamp createdAt;
  Timestamp updatedAt;

  UserBuilder();

  UserBuilder.fromMap(Map<String, dynamic> map)
      : uid = map["uid"],
        name = map["name"],
        lastName = map["lastName"],
        phone = map["phone"],
        email = map["email"],
        photoURL = map["photoURL"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

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

  CustomUser({@required UserBuilder builder})
      : uid = builder.uid,
        name = builder.name,
        lastName = builder.lastName,
        phone = builder.phone,
        email = builder.email,
        photoURL = builder.photoURL,
        createdAt = builder.createdAt,
        updatedAt = builder.updatedAt;

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
    };
  }

  @override
  String toString() {
    return '\n********************************\n'
        '--- CustomUser ---'
        '\n>> uid: $uid'
        '\n>> name: $name'
        '\n>> lastName: $lastName'
        '\n>> phone: $phone'
        '\n>> email: $email'
        '\n>> photoURL: $photoURL'
        '\n>> createdAt: $createdAt'
        '\n>> updatedAt: $updatedAt'
        '\n********************************\n';
  }
}
