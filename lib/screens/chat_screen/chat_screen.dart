import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/chat_screen/custom_widget/input_field_chat.dart';
import 'package:swipe/screens/chat_screen/custom_widget/massage_item.dart';

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
  String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "${widget.userBuilder.name} ${widget.userBuilder.lastName}",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: ChatFirestoreAPI.getChat(
              ownerUID: widget.userBuilder.uid,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 75.0),
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    itemBuilder: (BuildContext context, int index) {
                      return MassageItem(
                        document: snapshot.data.docs[index],
                        userBuilder: widget.userBuilder,
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: Text("Здесь пока ничего нет..."),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InputFieldChat(
              onAttach: () {},
              onChanged: (String message) {
                setState(() => _message = message);
              },
              onSend: () {
                if (_message != null && _message.isNotEmpty) {
                  ChatFirestoreAPI.sendMassage(
                    ownerUID: widget.userBuilder.uid,
                    message: _message.trim(),
                  );
                  setState(() => _message = null);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
