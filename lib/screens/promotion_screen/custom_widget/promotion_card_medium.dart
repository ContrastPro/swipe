import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_apartment_item.dart';
import 'package:swipe/screens/promotion_screen/provider/promotion_provider.dart';

class PromotionCardMedium extends StatefulWidget {
  final String imageUrl;

  const PromotionCardMedium({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  _PromotionCardMediumState createState() => _PromotionCardMediumState();
}

class _PromotionCardMediumState extends State<PromotionCardMedium> {
  int _color;


  @override
  Widget build(BuildContext context) {
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

    Widget colored(PromotionNotifier promotionNotifier) {
      return GestureDetector(
        onTap: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circle(promotionNotifier.isColored),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotionNotifier.promotionList[0].title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.promotionTitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "${promotionNotifier.promotionList[0].price}₽/мес",
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

    Widget phrase(PromotionNotifier promotionNotifier) {
      return GestureDetector(
        onTap: () {

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circle(promotionNotifier.isPhrase),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotionNotifier.promotionList[1].title,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.promotionTitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  "${promotionNotifier.promotionList[1].price}₽/мес",
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

    return Consumer<PromotionNotifier>(
        builder: (context, promotionNotifier, child){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 40,
                child: Container(
                  height: 200,
                  child: PromotionApartmentItem(
                    imageUrl: widget.imageUrl,
                    isColored: promotionNotifier.isColored,
                    isPhrase: promotionNotifier.isPhrase,
                    color: _color,
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
                      colored(promotionNotifier),
                      if (promotionNotifier.isColored)
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
                                    setState(() {
                                      _color = AppColors.promotionColors[index].value;
                                    });
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
                              }),
                        ),
                      SizedBox(height: 15.0),
                      phrase(promotionNotifier),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}
