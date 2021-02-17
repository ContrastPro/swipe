import 'package:flutter/foundation.dart';
import 'package:swipe/screens/promotion_screen/model/promotion_card.dart';

class PromotionNotifier with ChangeNotifier {
  int _totalPrice = 0;
  bool _isColored = false;
  bool _isPhrase = false;
  List<PromotionCard> _promotionList = PromotionCard.promotionList;


  List<PromotionCard> get promotionList => _promotionList;

  int get totalPrice => _totalPrice;

  bool get isColored => _isColored;

  bool get isPhrase => _isPhrase;

  void setPriceBasic() {

    notifyListeners();
  }

  void incrementPriceBasic() {

    notifyListeners();
  }

  void makePayment() {}
}
