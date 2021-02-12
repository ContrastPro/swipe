import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class ProductItemIStyle3 extends StatelessWidget {

  final String imageUrl;
  final VoidCallback onTap;


  const ProductItemIStyle3({
    Key key,
    @required this.imageUrl,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
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
                      Text(
                        "1-к квартира, 28.5 м², 1/8 эт.",
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "р-н Центральный",
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "ул. Темерязева",
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Сегодня в 15:00",
                        style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
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
                child: Icon(
                  Icons.radio_button_off,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
