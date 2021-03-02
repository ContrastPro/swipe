import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_feedback.dart';
import 'package:swipe/model/notary.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/admin_panel/admin_notary_screen/custom_widget/notary_item_admin.dart';

import 'api/notary_firestore_admin_api.dart';

class AdminNotaryScreen extends StatelessWidget {
  void _editNotary(NotaryBuilder notaryBuilder) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Нотариусы",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: NetworkConnectivity(
        child: StreamBuilder<QuerySnapshot>(
          stream: NotaryFirestoreAdminApi.getNotary(),
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
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                itemBuilder: (BuildContext context, int index) {
                  return NotaryItemAdmin(
                    notaryBuilder: NotaryBuilder.fromMap(
                      snapshot.data.docs[index].data(),
                    ),
                    onTap: () {
                      _editNotary(
                        NotaryBuilder.fromMap(
                          snapshot.data.docs[index].data(),
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
