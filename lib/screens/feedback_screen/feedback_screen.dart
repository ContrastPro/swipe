import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_users.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/chat_screen/chat_screen.dart';
import 'package:swipe/screens/feedback_screen/custom_widget/person_card_feedback.dart';

import 'api/feedback_firestore_api.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Обратная связь",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: NetworkConnectivity(
        child: StreamBuilder<QuerySnapshot>(
          stream: FeedbackFirestoreAPI.getChats(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (!snapshot.hasData) {
              return ShimmerUsers();
            }

            if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return PersonCardFeedback(
                    document: snapshot.data.docs[index],
                    onTap: (UserBuilder userBuilder) {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: ChatScreen(
                            userBuilder: userBuilder,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Text("Здесь пока ничего нет..."),
              );
            }
          },
        ),
      ),
    );
  }
}
