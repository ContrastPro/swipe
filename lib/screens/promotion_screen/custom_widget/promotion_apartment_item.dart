import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/apartment.dart';

class PromotionApartmentItem extends StatelessWidget {
  final ApartmentBuilder apartmentBuilder;
  final List<File> imageFile;

  const PromotionApartmentItem({
    Key key,
    @required this.apartmentBuilder,
    @required this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildImage() {
      if (apartmentBuilder.images != null) {
        return Expanded(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: apartmentBuilder.images[0],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 2,
                  ),
                );
              },
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        );
      } else {
        return Expanded(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: FileImage(imageFile[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: apartmentBuilder.promotionBuilder.color != null
                  ? Color(apartmentBuilder.promotionBuilder.color)
                  : Colors.transparent,
            ),
            child: Column(
              children: [
                _buildImage(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0),
                    Text(
                      "${apartmentBuilder.price} ₽",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      "${apartmentBuilder.numberOfRooms}, "
                      "${apartmentBuilder.totalArea} м², "
                      "1/8 эт.",
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      "${apartmentBuilder.address}",
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      "Сегодня в ${DateFormat('Hm').format(DateTime.now())}",
                      style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 9.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ],
            ),
          ),
          if (apartmentBuilder.promotionBuilder.phrase != null)
            Positioned(
              left: 0,
              child: Container(
                height: 15.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 7.0,
                  vertical: 9.0,
                ),
                child: Text(
                  "${apartmentBuilder.promotionBuilder.phrase}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  gradient: AppColors.buttonGradient,
                ),
              ),
            ),
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.radio_button_off,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
