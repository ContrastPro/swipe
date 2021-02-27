import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/model/message.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/chat_screen/api/chat_image_picker.dart';
import 'package:swipe/screens/chat_screen/custom_widget/input_field_chat.dart';
import 'package:swipe/screens/chat_screen/custom_widget/massage_item.dart';
import 'package:swipe/screens/chat_screen/custom_widget/modal_bottom_sheet_chat.dart';

import 'api/chat_firestore_api.dart';

class ChatScreen extends StatefulWidget {
  final UserBuilder userBuilder;

  const ChatScreen({
    Key key,
    @required this.userBuilder,
  }) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<ChatScreen> {
  File _imageFile;
  MessageBuilder _messageBuilder;
  ScrollController _scrollController;

  @override
  void initState() {
    _messageBuilder = MessageBuilder();
    _scrollController = ScrollController();
    super.initState();
  }

  void _attachFile() async {
    File file = await ChatImagePicker.getLocalImage();
    setState(() => _imageFile = file);
  }

  void _sendMessage() async {
    if (_imageFile != null || _messageBuilder.message != null) {
      File imageFile = _imageFile;
      setState(() => _imageFile = null);
      await ChatFirestoreAPI.sendMassage(
        imageFile: imageFile,
        ownerUID: widget.userBuilder.uid,
        messageBuilder: _messageBuilder,
      );
      if (_scrollController.position.pixels != 0.0) {
        _scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 1000),
        );
      }
      setState(() {
        _messageBuilder.message = null;
        _messageBuilder.attachFile = null;
      });
    }
  }

  void _deleteMessage(DocumentSnapshot document) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheetChat(
          username: widget.userBuilder.name,
          deleteFromMe: () {
            ChatFirestoreAPI.deleteFromMe(
              ownerUID: widget.userBuilder.uid,
              documentID: document.id,
              attachFile: document["attachFile"],
            );
          },
          deleteEverywhere: () {
            ChatFirestoreAPI.deleteEverywhere(
              ownerUID: widget.userBuilder.uid,
              documentID: document.id,
              attachFile: document["attachFile"],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "${widget.userBuilder.name} ${widget.userBuilder.lastName}",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: NetworkConnectivity(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: ChatFirestoreAPI.getChat(
                ownerUID: widget.userBuilder.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Expanded(
                    child: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      itemCount: snapshot.data.docs.length,
                      reverse: true,
                      controller: _scrollController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return MassageItem(
                          messageBuilder: MessageBuilder.fromMap(
                            snapshot.data.docs[index].data(),
                          ),
                          userBuilder: widget.userBuilder,
                          onLongPress: () => _deleteMessage(
                            snapshot.data.docs[index],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text("Здесь пока ничего нет..."),
                    ),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InputFieldChat(
                imageFile: _imageFile,
                onChanged: (String message) {
                  setState(() => _messageBuilder.message = message);
                },
                onSend: () => _sendMessage(),
                onAttach: () => _attachFile(),
                onDeleteAttach: () {
                  setState(() {
                    _imageFile = null;
                    _messageBuilder.attachFile = null;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
