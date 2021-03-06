import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/format/time_format.dart';
import 'package:swipe/global/style/app_colors.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/apartment_screen/apartment_screen.dart';

import 'apartment_detail_dialog.dart';

class ApartmentItem extends StatelessWidget {
  final ApartmentBuilder apartmentBuilder;
  final VoidCallback onTap;

  const ApartmentItem({
    Key key,
    @required this.apartmentBuilder,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goToApartmentScreen() {
      Navigator.push(
        context,
        FadeRoute(
          page: ApartmentScreen(
            apartmentBuilder: apartmentBuilder,
          ),
        ),
      );
    }

    void showDetailDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return ApartmentDetailDialog(
            apartmentBuilder: apartmentBuilder,
            onTap: () => _goToApartmentScreen(),
          );
        },
      );
    }

    Widget buildImage() {
      return Expanded(
        child: GestureDetector(
          onTap: () => showDetailDialog(),
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
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildImage(),
                InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () => _goToApartmentScreen(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Text(
                        "${apartmentBuilder.price} ₽",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "${apartmentBuilder.numberOfRooms}, "
                        "${apartmentBuilder.totalArea} м², "
                        "1/8 эт.",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "${apartmentBuilder.address}",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "${TimeFormat.formatTime(apartmentBuilder.createdAt)}",
                        style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (apartmentBuilder.promotionBuilder.phrase != null)
            Positioned(
              left: 0,
              child: Container(
                height: 18.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                ),
                margin: const EdgeInsets.all(8.0),
                child: Text(
                  "${apartmentBuilder.promotionBuilder.phrase}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.5,
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
            child: GestureDetector(
              onTap: () => onTap(),
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
                    size: 22.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
