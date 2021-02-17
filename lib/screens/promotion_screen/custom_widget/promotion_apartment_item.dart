import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/screens/promotion_screen/provider/promotion_provider.dart';

class PromotionApartmentItem extends StatelessWidget {
  final String imageUrl;

  const PromotionApartmentItem({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildImage() {
      return Expanded(
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

    return Consumer<PromotionNotifier>(
      builder: (context, promotionNotifier, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: promotionNotifier.getIsColored
                      ? Color(promotionNotifier.getColor)
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
                          "3 400 000 ₽",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "1-к квартира, 28.5 м², 1/8 эт.",
                          style: TextStyle(
                            fontSize: 9.0,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "р-н Центральный ул. Темерязева",
                          style: TextStyle(
                            fontSize: 9.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "Сегодня в 15:00",
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
              if (promotionNotifier.getPhrase != null)
                Positioned(
                  left: 0,
                  child: Container(
                    height: 15.0,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 9.0,
                    ),
                    child: Text(
                      "${promotionNotifier.getPhrase}",
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
                      size: 19.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
