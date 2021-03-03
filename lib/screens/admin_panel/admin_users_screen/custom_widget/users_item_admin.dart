import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/custom_user.dart';

class UsersItemAdmin extends StatelessWidget {
  final UserBuilder userBuilder;
  final VoidCallback onTap;
  final String ownerUID;

  const UsersItemAdmin({
    Key key,
    @required this.userBuilder,
    @required this.onTap,
    @required this.ownerUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildImage() {
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
            "${userBuilder.name[0].toUpperCase()}"
            "${userBuilder.lastName[0].toUpperCase()}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        );
      }
    }

    Widget buildTrailing() {
      if (ownerUID != userBuilder.uid) {
        return IconButton(
          icon: Icon(
            Icons.block_rounded,
            color: Colors.black,
          ),
          onPressed: () => onTap(),
        );
      }
      return SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        leading: buildImage(),
        title: Text(
          "${userBuilder.name} ${userBuilder.lastName}",
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userBuilder.phone,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            Text(
              userBuilder.email,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        trailing: buildTrailing(),
      ),
    );
  }
}
