import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/promotion_screen/model/promotion_card.dart';

class MakePayment {
  static Future<void> makePayment({
    @required ApartmentBuilder apartmentBuilder,
    @required List<PromotionCard> list,
    @required int price,
  }) async {
    if (price == list[2].price) {
      apartmentBuilder.promotionBuilder.isBigAd = true;
      apartmentBuilder.promotionBuilder.adWeight = 0;
    } else if (price == list[3].price) {
      apartmentBuilder.promotionBuilder.isBigAd = false;
      apartmentBuilder.promotionBuilder.adWeight = 1;
    } else if (price == list[4].price) {
      apartmentBuilder.promotionBuilder.isBigAd = false;
      apartmentBuilder.promotionBuilder.adWeight = 2;
    } else {
      apartmentBuilder.promotionBuilder.isBigAd = false;
      apartmentBuilder.promotionBuilder.adWeight = 0;
    }
    log("$apartmentBuilder");
  }

  static Future<void> addWithoutPayment({
    @required ApartmentBuilder apartmentBuilder,
  }) async {
    apartmentBuilder.promotionBuilder.color = null;
    apartmentBuilder.promotionBuilder.phrase = null;
    apartmentBuilder.promotionBuilder.isBigAd = false;
    apartmentBuilder.promotionBuilder.adWeight = 0;
    log("$apartmentBuilder");
  }
}
