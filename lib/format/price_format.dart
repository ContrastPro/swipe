import 'package:flutter/material.dart';

class PriceFormat {
  PriceFormat._();

  static String formatPrice({@required String price}) {
    var value = price;
    if (price.length > 2) {
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ' ');
    }
    return value;
  }
}
