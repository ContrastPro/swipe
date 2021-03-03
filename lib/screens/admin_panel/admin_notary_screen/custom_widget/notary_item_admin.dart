import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/notary.dart';

class NotaryItemAdmin extends StatelessWidget {
  final NotaryBuilder notaryBuilder;
  final VoidCallback onTap;

  const NotaryItemAdmin({
    Key key,
    @required this.notaryBuilder,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            if(notaryBuilder.email != null)...[
              Text(
                notaryBuilder.email,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.edit_outlined,
            color: Colors.black,
          ),
          onPressed: () => onTap(),
        ),
      ),
    );
  }
}
