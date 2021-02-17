import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/screens/promotion_screen/provider/promotion_provider.dart';

class PromotionCardSmall extends StatelessWidget {
  final int initialIndex;

  const PromotionCardSmall({
    Key key,
    @required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PromotionNotifier>(
      builder: (context, promotionNotifier, child) {
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
              color: initialIndex == promotionNotifier.getCurrentIndex
                  ? Color(0xFF65DED5)
                  : Colors.transparent,
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
                  promotionNotifier.getPromotionList[initialIndex + 2].image,
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
                        promotionNotifier
                            .getPromotionList[initialIndex + 2].title,
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
                                width: 30 *
                                    promotionNotifier
                                        .getPromotionList[initialIndex + 2]
                                        .efficiency,
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
                              "${promotionNotifier.getPromotionList[initialIndex + 2].price}₽/мес",
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
      },
    );
  }
}
