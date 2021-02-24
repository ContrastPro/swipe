import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/shimmer/shimmer_feedback.dart';
import 'package:swipe/format/time_format.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/apartment_screen/api/apartment_firestore_api.dart';

class PersonCardFeedback extends StatelessWidget {
  final DocumentSnapshot document;
  final ValueChanged<UserBuilder> onTap;

  const PersonCardFeedback({
    Key key,
    @required this.document,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildImage(UserBuilder userBuilder) {
      String name = userBuilder.name[0].toUpperCase();
      String lastName = userBuilder.lastName[0].toUpperCase();

      if (userBuilder.photoURL != null) {
        return CachedNetworkImage(
          imageUrl: userBuilder.photoURL,
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
            "$name$lastName",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        );
      }
    }

    return FutureBuilder<UserBuilder>(
      future: ApartmentFirestoreAPI.getOwnerProfile(
        ownerUID: document.id,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListTile(
            hoverColor: Colors.transparent,
            leading: buildImage(snapshot.data),
            title: Text(
              "${snapshot.data.name} ${snapshot.data.lastName}",
            ),
            subtitle: Text(
              "${TimeFormat.formatTimeMessage(document["lastActivity"])}",
            ),
            onTap: () => onTap(snapshot.data),
          );
        }
        return ShimmerFeedback();
      },
    );
  }
}
