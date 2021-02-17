import 'package:flutter/foundation.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/promotion_screen/model/promotion_card.dart';

class PromotionNotifier with ChangeNotifier {
  // Index in ListView
  int _currentIndex;

  int get getCurrentIndex => _currentIndex;

  set setCurrentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  // Count total price
  int _totalPrice = 0;

  int get getPrice => _totalPrice;

  // Color logic
  bool _isColored = false;

  bool get getIsColored => _isColored;

  int _color = AppColors.promotionColors[0].value;

  int get getColor => _color;

  set setColor(int color) {
    _color = color;
    notifyListeners();
  }

  // Phrase logic
  bool _isPhrase = false;

  bool get getIsPhrase => _isPhrase;

  String _phrase;

  String get getPhrase => _phrase;

  //
  List<PromotionCard> _promotionList = PromotionCard.promotionList;

  List<PromotionCard> get getPromotionList => _promotionList;

  //

  void setSimplePrice(int index) {
    _totalPrice = _promotionList[index].price;
    notifyListeners();
  }

  void switchIsColored(int index) {
    _currentIndex = null;
    if (_isColored == false && _phrase == null) {
      _totalPrice = _promotionList[index].price;
    } else if (_isColored == false) {
      _totalPrice += _promotionList[index].price;
    } else {
      _totalPrice -= _promotionList[index].price;
    }
    _isColored = !_isColored;
    notifyListeners();
  }

  void setPhrase(int index, String phrase) {
    _phrase = phrase;
    if (_isColored == false) {
      _totalPrice = _promotionList[index].price;
    } else {
      _totalPrice += _promotionList[index].price;
    }
    notifyListeners();
  }

  void switchIsPhrase() {
    _currentIndex = null;
    _isPhrase = !_isPhrase;
    notifyListeners();
  }

  void disableColoredPhrase() {
    _isColored = false;
    _isPhrase = false;
    notifyListeners();
  }

  void makePayment(ApartmentBuilder apartmentBuilder) {}

  void addWithoutPayment(ApartmentBuilder apartmentBuilder) {}
}
