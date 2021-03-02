import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBuilder {
  String id;
  String ownerUID;
  String message;
  String attachFile;
  Timestamp createAt;
  Timestamp updateAt;

  MessageBuilder();

  MessageBuilder.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        ownerUID = map["ownerUID"],
        message = map["message"],
        attachFile = map["attachFile"],
        updateAt = map["updateAt"],
        createAt = map["createAt"];

  @override
  String toString() {
    return '\n********************************\n'
        '--- MessageBuilder ---'
        '\n>> id: $id'
        '\n>> ownerUID: $ownerUID'
        '\n>> message: $message'
        '\n>> attachFile: $attachFile'
        '\n>> createAt: ${createAt?.toDate()}'
        '\n>> updateAt: ${updateAt?.toDate()}'
        '\n********************************\n';
  }
}

class Message {
  final String id;
  final String ownerUID;
  final String message;
  final String attachFile;
  final Timestamp createAt;
  final Timestamp updateAt;

  Message(MessageBuilder messageBuilder)
      : id = messageBuilder.id,
        ownerUID = messageBuilder.ownerUID,
        message = messageBuilder.message?.trim(),
        attachFile = messageBuilder.attachFile,
        createAt = messageBuilder.createAt,
        updateAt = messageBuilder.updateAt;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "ownerUID": ownerUID,
      "message": message,
      "attachFile": attachFile,
      "createAt": createAt,
      "updateAt": updateAt,
    };
  }
}
