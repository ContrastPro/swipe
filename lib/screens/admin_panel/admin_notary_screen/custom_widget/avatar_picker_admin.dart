import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class AvatarPickerAdmin extends StatelessWidget {
  final String photoURL;
  final File imageFile;
  final VoidCallback onTap;
  final Color color;
  final double thickness;
  final double radius;

  const AvatarPickerAdmin({
    Key key,
    @required this.photoURL,
    @required this.imageFile,
    @required this.onTap,
    this.color = Colors.black38,
    this.thickness = 30.0,
    this.radius = 80.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget addPhoto({Widget child}) {
      return Stack(
        alignment: Alignment.bottomRight,
        children: [
          child,
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 23.0,
                height: 23.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => onTap(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45.0),
                    color: AppColors.accentColor,
                  ),
                  width: 19.0,
                  height: 19.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      size: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget avatar;
    if (imageFile != null) {
      avatar = addPhoto(
        child: CircleAvatar(
          radius: radius / 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (photoURL != null) {
      avatar = addPhoto(
        child: CachedNetworkImage(
          imageUrl: photoURL,
          imageBuilder: (context, imageProvider) => CircleAvatar(
            backgroundImage: imageProvider,
            radius: radius / 2,
          ),
          placeholder: (context, url) => Container(
            width: radius,
            height: radius,
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Container(
            width: radius,
            height: radius,
            child: Icon(Icons.error_outline_rounded),
          ),
        ),
      );
    } else if (photoURL == null && imageFile == null) {
      avatar = GestureDetector(
        onTap: () => onTap(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: radius,
              height: radius,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color),
              ),
            ),
            Container(width: thickness, height: 1.0, color: color),
            Container(width: 1.0, height: thickness, color: color),
          ],
        ),
      );
    }
    return avatar;
  }
}
