import 'package:flutter/material.dart';
import 'package:swipe/global/style/app_colors.dart';
import 'package:swipe/screens/promotion_screen/model/promotion_card.dart';

class PromotionCardSmall extends StatelessWidget {
  final int index;
  final int currentIndex;
  final List<PromotionCard> promotionList;

  const PromotionCardSmall({
    Key key,
    @required this.index,
    @required this.currentIndex,
    @required this.promotionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 105,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 8.0,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: index == currentIndex ? Color(0xFF65DED5) : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: AppColors.promotionCardShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 30,
            child: Image.asset(
              promotionList[index + 2].image,
            ),
          ),
          Expanded(
            flex: 70,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promotionList[index + 2].title,
                    style: TextStyle(
                      color: AppColors.promotionTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
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
                            width: 30 * promotionList[index + 2].efficiency,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF65DED5),
                                  Color(0xFF75FADB),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${promotionList[index + 2].price}₽/мес",
                          style: TextStyle(
                            color: AppColors.promotionTitle,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                          ),
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
