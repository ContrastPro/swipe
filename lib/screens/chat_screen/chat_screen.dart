import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/format/time_format.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/model/message.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/chat_screen/api/chat_image_picker.dart';
import 'package:swipe/screens/chat_screen/custom_widget/blocked_field_chat.dart';
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
  String _message;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  void _attachFile() async {
    File file = await ChatImagePicker.getLocalImage();
    setState(() => _imageFile = file);
  }

  void _sendMessage() async {
    if (_imageFile != null || _message != null && _message.trim() != "") {
      MessageBuilder messageBuilder = MessageBuilder();
      File imageFile = _imageFile;
      messageBuilder.message = _message;

      setState(() {
        _message = null;
        _imageFile = null;
      });
      await ChatFirestoreAPI.sendMassage(
        imageFile: imageFile,
        ownerUID: widget.userBuilder.uid,
        messageBuilder: messageBuilder,
      );
      if (_scrollController.position.pixels != 0.0) {
        _scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 1000),
        );
      }
    }
  }

  void _deleteMessage({MessageBuilder messageBuilder}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalBottomSheetChat(
          username: widget.userBuilder.name,
          deleteFromMe: () {
            ChatFirestoreAPI.deleteFromMe(
              ownerUID: widget.userBuilder.uid,
              messageBuilder: messageBuilder,
            );
          },
          deleteEverywhere: () {
            ChatFirestoreAPI.deleteEverywhere(
              ownerUID: widget.userBuilder.uid,
              messageBuilder: messageBuilder,
            );
          },
        );
      },
    );
  }

  Widget _buildDate(String date) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 1.5,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          date,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader({
    int index,
    int itemCount,
    List<DocumentSnapshot> listDocument,
  }) {
    if (index < itemCount - 1) {
      Timestamp date1 = listDocument[index]["createdAt"];
      Timestamp date2 = listDocument[index + 1]["createdAt"];
      if (TimeFormat.compareDates(date1) != TimeFormat.compareDates(date2)) {
        return _buildDate(TimeFormat.formatDateMessage(date1));
      } else {
        return SizedBox();
      }
    } else {
      return _buildDate(TimeFormat.formatDateMessage(
        listDocument[index]["createdAt"],
      ));
    }
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
                      itemBuilder: (context, index) {
                        return StickyHeader(
                          header: _buildHeader(
                            index: index,
                            itemCount: snapshot.data.docs.length,
                            listDocument: snapshot.data.docs,
                          ),
                          content: MassageItem(
                            messageBuilder: MessageBuilder.fromMap(
                              snapshot.data.docs[index].data(),
                            ),
                            userBuilder: widget.userBuilder,
                            onLongPress: () => _deleteMessage(
                              messageBuilder: MessageBuilder.fromMap(
                                snapshot.data.docs[index].data(),
                              ),
                            ),
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
              child: widget.userBuilder.isBanned == false
                  ? InputFieldChat(
                      imageFile: _imageFile,
                      onChanged: (String message) {
                        setState(() => _message = message);
                      },
                      onSend: () => _sendMessage(),
                      onAttach: () => _attachFile(),
                      onDeleteAttach: () {
                        setState(() => _imageFile = null);
                      },
                    )
                  : BlockedFieldChat(
                      username: widget.userBuilder.name,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
