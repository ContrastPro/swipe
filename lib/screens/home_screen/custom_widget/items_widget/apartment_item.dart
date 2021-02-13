import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/screens/home_screen/custom_widget/items_widget/apartment_detail_dialog.dart';

class ApartmentItem extends StatelessWidget {
  final List<String> imageUrl;
  final VoidCallback onTap;

  const ApartmentItem({
    Key key,
    @required this.imageUrl,
    @required this.onTap,
  }) : super(key: key);

  final bool _isColored = false;
  final bool _isPhrase = false;

  @override
  Widget build(BuildContext context) {
    void _showDetailDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return ApartmentDetailDialog(
            imageUrl: imageUrl,
            onTap: () {},
          );
        },
      );
    }

    Widget _buildImage() {
      return Expanded(
        child: GestureDetector(
          onTap: () => _showDetailDialog(),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: imageUrl[0],
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
              color: _isColored ? Colors.green.shade50 : Colors.transparent,
            ),
            child: Column(
              children: [
                _buildImage(),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Text(
                        "3 400 000 ₽",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "1-к квартира, 28.5 м², 1/8 эт.",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "р-н Центральный ул. Темерязева",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        "Сегодня в 15:00",
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
          if (_isPhrase)
            Positioned(
              left: 0,
              child: Container(
                height: 18.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 9.0,
                ),
                child: Text(
                  "Квартира у моря",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
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
