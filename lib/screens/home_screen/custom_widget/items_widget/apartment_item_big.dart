import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/apartment.dart';

class ApartmentItemBig extends StatelessWidget {
  final ApartmentBuilder apartmentBuilder;
  final VoidCallback onTap;

  const ApartmentItemBig({
    Key key,
    @required this.apartmentBuilder,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildImage() {
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
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              _buildImage(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "3 400 000 ₽",
                        style: TextStyle(
                          fontSize: 23.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Flexible(
                        child: Text(
                          "1-к квартира, 28.5 м², 1/8 эт.",
                          style: TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          "р-н Центральный ул. Темерязева",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Сегодня в 15:00",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: AppColors.accentColor,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ],
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
