import 'package:flutter/material.dart';

class PromotionBuilder {
  int color;
  String phrase;

  PromotionBuilder();

  PromotionBuilder.fromMap(Map<String, dynamic> json)
      : color = json['color'],
        phrase = json['phrase'];

  @override
  String toString() {
    return '{color: $color phrase: $phrase}';
  }
}

class Promotion {
  final int color;

  Promotion({@required PromotionBuilder promotionBuilder})
      : color = promotionBuilder.color;

  Map<String, dynamic> toMap() {
    return {
      "color": color,
    };
  }
}
