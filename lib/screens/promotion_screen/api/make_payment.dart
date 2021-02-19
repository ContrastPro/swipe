import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/screens/promotion_screen/api/promotion_cloudstore_api.dart';
import 'package:swipe/screens/promotion_screen/api/promotion_firestore_api.dart';
import 'package:swipe/screens/promotion_screen/model/promotion_card.dart';
import 'package:uuid/uuid.dart';

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

  static Future<void> uploadWithoutPayment({
    @required ApartmentBuilder apartmentBuilder,
    @required List<File> imageList,
  }) async {
    // Устанавливаем значения продвижения
    apartmentBuilder.promotionBuilder.color = null;
    apartmentBuilder.promotionBuilder.phrase = null;
    apartmentBuilder.promotionBuilder.isBigAd = false;
    apartmentBuilder.promotionBuilder.adWeight = 0;
    // Загрузить лист фото и вернуть лист ссылок
    apartmentBuilder.images = await Future.wait(imageList.map((image) {
      return PromotionCloudstoreAPI.uploadApartmentImage(imageFile: image);
    }));
    // Загрузить в БД
    final User user = AuthFirebaseAPI.getCurrentUser();
    apartmentBuilder.id = Uuid().v4();
    apartmentBuilder.ownerUID = user.uid;
    apartmentBuilder.createdAt = Timestamp.now();
    await PromotionFirestoreAPI.uploadApartment(
      apartment: Apartment(apartmentBuilder: apartmentBuilder),
    );

    log("$apartmentBuilder");
  }
}
