import 'package:cloud_firestore/cloud_firestore.dart';

class NewsBuilder {
  String title;
  String description;
  Timestamp createdAt;

  NewsBuilder();

  NewsBuilder.fromMap(Map<String, dynamic> map)
      : title = map["title"],
        description = map["description"],
        createdAt = map["createdAt"];
}
