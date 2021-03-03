import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/promotion_screen/model/promotion_card.dart';

import 'promotion_apartment_item.dart';

class PromotionCardMedium extends StatelessWidget {
  final ApartmentBuilder apartmentBuilder;
  final List<PromotionCard> promotionList;
  final List<File> imageFile;
  final bool addColor;
  final VoidCallback changeColor;
  final VoidCallback changePhrase;
  final ValueChanged<int> colorPicked;

  const PromotionCardMedium({
    Key key,
    @required this.apartmentBuilder,
    @required this.promotionList,
    @required this.imageFile,
    @required this.addColor,
    @required this.changeColor,
    @required this.changePhrase,
    @required this.colorPicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget circle(bool value) {
      return Container(
        width: 15.0,
        height: 15.0,
        margin: EdgeInsets.only(top: 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45.0),
          color: value ? AppColors.accentColor : Colors.black.withAlpha(40),
        ),
      );
    }

    Widget colored() {
      return InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => changeColor(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circle(apartmentBuilder.promotionBuilder.color != null),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotionList[0].title,
                  style: TextStyle(
                    fontSize: 15.5,
                    color: AppColors.promotionTitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "${promotionList[0].price}₽/мес",
                  style: TextStyle(
                    fontSize: 15.0,
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

    Widget colors() {
      return AnimatedContainer(
        height: addColor ? 60 : 0,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: const EdgeInsets.only(bottom: 15.0),
        child: ListView.builder(
          itemCount: AppColors.promotionColors.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => colorPicked(AppColors.promotionColors[index].value),
              child: Container(
                width: 30,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: apartmentBuilder.promotionBuilder.color ==
                            AppColors.promotionColors[index].value
                        ? AppColors.accentColor
                        : Colors.transparent,
                  ),
                  color: AppColors.promotionColors[index],
                ),
              ),
            );
          },
        ),
      );
    }

    Widget phrase() {
      return InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => changePhrase(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circle(apartmentBuilder.promotionBuilder.phrase != null),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promotionList[1].title,
                  style: TextStyle(
                    fontSize: 15.5,
                    color: AppColors.promotionTitle,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  "${promotionList[1].price}₽/мес",
                  style: TextStyle(
                    fontSize: 15.5,
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
              imageFile: imageFile,
              apartmentBuilder: apartmentBuilder,
            ),
          ),
        ),
        Expanded(
          flex: 60,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                colored(),
                colors(),
                phrase(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
