import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_feedback.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/notary_screen/api/notary_firestore_api.dart';
import 'package:url_launcher/url_launcher.dart';

class NotaryScreen extends StatelessWidget {

  void _makePhoneCall(String phoneNumber) async {
    String phone = "tel:$phoneNumber";
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not launch $phone';
    }
  }

  Widget _notaryItem(DocumentSnapshot document){
    return ListTile(
      title: Text("${document["name"]} ${document["lastName"]}"),
      subtitle: Text(document["phone"]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Нотариусы",
        onTapLeading: () => NotaryFirestoreAPI.addNotary(),
        onTapAction: () => Navigator.pop(context),
      ),
      body: NetworkConnectivity(
        child: StreamBuilder<QuerySnapshot>(
          stream: NotaryFirestoreAPI.getNotary(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (!snapshot.hasData) {
              return ShimmerFeedback();
            }

            if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return _notaryItem(snapshot.data.docs[index]);
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
