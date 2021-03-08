import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/custom_app_widget/modal_bottom_sheet.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_users.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/global/firebase_api.dart';

import 'api/users_firestore_admin_api.dart';
import 'custom_widget/users_item_admin.dart';

class AdminUsersScreen extends StatefulWidget {
  @override
  _AdminUsersScreenState createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  bool _startLoading = false;
  User _user;

  @override
  void initState() {
    _user = FirebaseAPI.currentUser();
    super.initState();
  }

  void _blockUnblockUser({
    BuildContext context,
    DocumentSnapshot document,
  }) async {
    if (document["isBanned"] == true) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ModalBottomSheet(
            title: "Разблокировать ${document["name"]} ${document["lastName"]}",
            subtitle: "Этот пользователь снова сможет войти в приложение. "
                "Продолжить?",
            onAccept: () async {
              setState(() => _startLoading = true);
              await UsersFirestoreAdminAPI.unblockUser(uid: document.id);
              setState(() => _startLoading = false);
            },
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ModalBottomSheet(
            title: "Заблокировать ${document["name"]} ${document["lastName"]}",
            subtitle: "Этот пользователь не сможет войти в приложение, "
                "все объявления будут удалены навсегда. Продолжить?",
            onAccept: () async {
              setState(() => _startLoading = true);
              await UsersFirestoreAdminAPI.blockUser(uid: document.id);
              setState(() => _startLoading = false);
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBarStyle1(
            title: "Пользователи",
            onTapLeading: () => Navigator.pop(context),
            onTapAction: () => Navigator.pop(context),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: UsersFirestoreAdminAPI.getUsers(),
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
                  padding: const EdgeInsets.symmetric(vertical: 11.0),
                  itemBuilder: (BuildContext context, int index) {
                    return UsersItemAdmin(
                      userBuilder: UserBuilder.fromMap(
                        snapshot.data.docs[index].data(),
                      ),
                      ownerUID: _user.uid,
                      onTap: () => _blockUnblockUser(
                        context: context,
                        document: snapshot.data.docs[index],
                      ),
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
        if (_startLoading == true) WaveIndicator(),
      ],
    );
  }
}
