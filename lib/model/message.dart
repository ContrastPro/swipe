import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBuilder {
  String ownerUID;
  String message;
  String attachFile;
  Timestamp createAt;

  MessageBuilder();

  MessageBuilder.fromMap(Map<String, dynamic> map)
      : ownerUID = map["ownerUID"],
        message = map["message"],
        attachFile = map["attachFile"],
        createAt = map["createAt"];

  @override
  String toString() {
    return '\n********************************\n'
        '--- MessageBuilder ---'
        '\n>> ownerUID: $ownerUID'
        '\n>> message: $message'
        '\n>> attachFile: $attachFile'
        '\n>> createAt: ${createAt?.toDate()}'
        '\n********************************\n';
  }
}

class Message {
  final String ownerUID;
  final String message;
  final String attachFile;
  final Timestamp createAt;

  Message(MessageBuilder messageBuilder)
      : ownerUID = messageBuilder.ownerUID,
        message = messageBuilder.message?.trim(),
        attachFile = messageBuilder.attachFile,
        createAt = messageBuilder.createAt;

  Map<String, dynamic> toMap() {
    return {
      "ownerUID": ownerUID,
      "message": message,
      "attachFile": attachFile,
      "createAt": createAt,
    };
  }
}
