import 'package:flutter/material.dart';

class UserBuilder {
  String name;
  String lastName;
  String phone;
  String email;
}

class CustomUser {
  final String name;
  final String lastName;
  final String phone;
  final String email;

  CustomUser({@required UserBuilder builder})
      : name = builder.name,
        lastName = builder.lastName,
        phone = builder.phone,
        email = builder.email;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lastName": lastName,
      "phone": phone,
      "email": email,
    };
  }
}
