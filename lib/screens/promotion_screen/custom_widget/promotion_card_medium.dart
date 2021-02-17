import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_apartment_item.dart';
import 'package:swipe/screens/promotion_screen/provider/promotion_provider.dart';

class PromotionCardMedium extends StatelessWidget {
  final String imageUrl;

  const PromotionCardMedium({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PromotionNotifier promotionNotifier =
        Provider.of<PromotionNotifier>(context);

    Widget circle(bool value) {
      return Container(
        width: 16.0,
        height: 16.0,
        margin: EdgeInsets.only(top: 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: value ? AppColors.accentColor : Colors.black.withAlpha(40),
        ),
      );
    }

    Widget colored() {
      return GestureDetector(
        onTap: () {
          promotionNotifier.switchIsColored(0);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circle(promotionNotifier.getIsColored),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotionNotifier.getPromotionList[0].title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.promotionTitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "${promotionNotifier.getPromotionList[0].price}₽/мес",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black.withAlpha(108),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget phrase() {
      return GestureDetector(
        onTap: () {
          promotionNotifier.switchIsPhrase();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circle(promotionNotifier.getPhrase != null),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotionNotifier.getPromotionList[1].title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.promotionTitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  "${promotionNotifier.getPromotionList[1].price}₽/мес",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black.withAlpha(108),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 40,
          child: Container(
            height: 200,
            child: PromotionApartmentItem(
              imageUrl: imageUrl,
            ),
          ),
        ),
        Expanded(
          flex: 60,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 12.0, 12.0, 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                colored(),
                if (promotionNotifier.getIsColored)
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 10.0),
                    child: ListView.builder(
                      itemCount: AppColors.promotionColors.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            promotionNotifier.setColor =
                                AppColors.promotionColors[index].value;
                          },
                          child: Container(
                            width: 30,
                            margin: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: AppColors.promotionColors[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                SizedBox(height: 15.0),
                phrase(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
