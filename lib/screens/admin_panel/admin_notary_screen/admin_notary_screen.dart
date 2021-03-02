import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_feedback.dart';
import 'package:swipe/model/notary.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';

import 'api/notary_firestore_admin_api.dart';

class AdminNotaryScreen extends StatelessWidget {
  Widget _buildImage(NotaryBuilder notaryBuilder) {
    if (notaryBuilder.photoURL != null) {
      return CachedNetworkImage(
        imageUrl: notaryBuilder.photoURL,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Container(
          width: 20.0,
          height: 20.0,
          child: Icon(
            Icons.error_outline_outlined,
            color: Colors.redAccent,
          ),
        ),
      );
    } else {
      return CircleAvatar(
        backgroundColor: Colors.black.withAlpha(50),
        child: Text(
          "${notaryBuilder.name[0].toUpperCase()}"
              "${notaryBuilder.lastName[0].toUpperCase()}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      );
    }
  }

  Widget _notaryItem(NotaryBuilder notaryBuilder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        leading: _buildImage(notaryBuilder),
        title: Text(
          "${notaryBuilder.name} ${notaryBuilder.lastName}",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notaryBuilder.phone,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            Text(
              notaryBuilder.email,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
    );
  }

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
                  return _notaryItem(
                    NotaryBuilder.fromMap(
                      snapshot.data.docs[index].data(),
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
    );
  }
}
