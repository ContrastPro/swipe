import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_users.dart';
import 'package:swipe/global/firebase_api.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/admin_panel/admin_users_screen/custom_widget/users_item_admin.dart';


import 'api/blacklist_firestore_admin_api.dart';

class AdminBlacklistScreen extends StatelessWidget {
  final User _user = FirebaseAPI.currentUser();

  void _unblockUser({DocumentSnapshot document}) {
    BlacklistFirestoreAdminAPI.unblockUser(uid: document.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Blacklist",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: BlacklistFirestoreAdminAPI.getBlacklist(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (!snapshot.hasData) {
            return ShimmerUsers();
          }

          if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 11.0),
                  itemBuilder: (BuildContext context, int index) {
                    return UsersItemAdmin(
                      userBuilder: UserBuilder.fromMap(
                        snapshot.data.docs[index].data(),
                      ),
                      ownerUID: _user.uid,
                      onTap: () => _unblockUser(
                        document: snapshot.data.docs[index],
                      ),
                    );
                  },
                ),
              ],
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
