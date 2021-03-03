import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_users.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

import 'api/users_firestore_admin_api.dart';
import 'custom_widget/users_item_admin.dart';

class AdminUsersScreen extends StatelessWidget {
  final User _user = AuthFirebaseAPI.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Пользователи",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: NetworkConnectivity(
        child: StreamBuilder<QuerySnapshot>(
          stream: UsersFirestoreAdminApi.getUsers(),
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
                        onTap: () {
                          //
                        },
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
      ),
    );
  }
}
