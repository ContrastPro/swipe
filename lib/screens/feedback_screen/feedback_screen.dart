import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/screens/chat_screen/chat_screen.dart';

import 'api/feedback_firestore_api.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Widget _buildItem(DocumentSnapshot document) {
    return ListTile(
      title: Text("${document.id}"),
      subtitle: Text(
        document["lastMessage"],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        log("${document.id}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Обратная связь",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FeedbackFirestoreAPI.getChats(),
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
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(snapshot.data.docs[index]);
              },
            );
          } else {
            return Center(
              child: Text("Здесь пока ничего нет..."),
            );
          }
        },
      ),
    );
  }
}
