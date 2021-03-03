import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBuilder {
  String id;
  String ownerUID;
  String message;
  String attachFile;
  Timestamp createdAt;
  Timestamp updatedAt;

  MessageBuilder();

  MessageBuilder.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        ownerUID = map["ownerUID"],
        message = map["message"],
        attachFile = map["attachFile"],
        createdAt = map["createdAt"],
        updatedAt = map["updatedAt"];

  @override
  String toString() {
    return '\n********************************\n'
        '--- MessageBuilder ---'
        '\n>> id: $id'
        '\n>> ownerUID: $ownerUID'
        '\n>> message: $message'
        '\n>> attachFile: $attachFile'
        '\n>> createdAt: ${createdAt?.toDate()}'
        '\n>> updatedAt: ${updatedAt?.toDate()}'
        '\n********************************\n';
  }
}

class Message {
  final String id;
  final String ownerUID;
  final String message;
  final String attachFile;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Message(MessageBuilder messageBuilder)
      : id = messageBuilder.id,
        ownerUID = messageBuilder.ownerUID,
        message = messageBuilder.message?.trim(),
        attachFile = messageBuilder.attachFile,
        createdAt = messageBuilder.createdAt,
        updatedAt = messageBuilder.updatedAt;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "ownerUID": ownerUID,
      "message": message,
      "attachFile": attachFile,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}
