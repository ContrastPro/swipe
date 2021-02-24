import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/custom_user.dart';

class OwnerInfoField extends StatelessWidget {
  final UserBuilder userBuilder;

  const OwnerInfoField({
    Key key,
    @required this.userBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildImage() {
      String name = userBuilder.name[0].toUpperCase();
      String lastName = userBuilder.lastName[0].toUpperCase();

      if (userBuilder.photoURL != null) {
        return CachedNetworkImage(
          imageUrl: userBuilder.photoURL,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
            radius: 25.0,
          ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Container(
            width: 25.0,
            height: 25.0,
            child: Icon(
              Icons.error_outline_outlined,
              color: Colors.redAccent,
            ),
          ),
        );
      } else {
        return CircleAvatar(
          backgroundColor: Colors.black.withAlpha(50),
          radius: 25.0,
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

    return Container(
      height: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black.withAlpha(25),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImage(),
          SizedBox(width: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${userBuilder.name} ${userBuilder.lastName}",
                style: TextStyle(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "частное лицо",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
