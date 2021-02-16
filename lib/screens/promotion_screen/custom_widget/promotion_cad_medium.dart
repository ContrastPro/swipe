import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class PromotionCardMedium extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subTitle;
  final String price;
  final double efficiency;

  const PromotionCardMedium({
    Key key,
    this.leading,
    this.title,
    this.subTitle,
    this.price,
    this.efficiency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 8.0,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: AppColors.promotionCardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 36,
            child: leading,
          ),
          Expanded(
            flex: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Color(0xFF374252),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        subTitle,
                        style: TextStyle(
                          color: Colors.black54,
                          //fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Эффективность",
                        style: TextStyle(
                          color: Colors.black54,
                          //fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(width: 10),
                      Stack(
                        children: [
                          Container(
                            width: 30,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFFE9EFF5),
                            ),
                          ),
                          Container(
                            width: 30 * efficiency,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color(0xFF65DED5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Text(
                        "$price₽/мес",
                        style: TextStyle(
                          color: Color(0xFF374252),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
