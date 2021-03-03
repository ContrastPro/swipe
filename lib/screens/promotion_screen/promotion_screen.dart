import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/home_screen/home_screen.dart';

import 'api/make_payment.dart';
import 'custom_widget/promotion_card_medium.dart';
import 'custom_widget/promotion_card_small.dart';
import 'custom_widget/promotion_phrase_picker.dart';
import 'model/promotion_card.dart';

class PromotionScreen extends StatefulWidget {
  final ApartmentBuilder apartmentBuilder;
  final List<File> imageList;

  const PromotionScreen({
    Key key,
    @required this.apartmentBuilder,
    this.imageList,
  }) : super(key: key);

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  int _currentIndex;
  int _totalPrice = 0;
  bool _addColor = false;
  bool _addPhrase = false;
  bool _startLoading = false;
  List<int> _complexPrice = List<int>();

  ApartmentBuilder _apartmentBuilder;
  List<PromotionCard> _promotionList;

  @override
  void initState() {
    _apartmentBuilder = widget.apartmentBuilder;
    _promotionList = PromotionCard.promotionList;
    super.initState();
  }

  void _setBasicPosition(int price) {
    if (!_complexPrice.contains(price)) {
      _complexPrice.add(price);
    }
    setState(() {
      _totalPrice = _complexPrice.reduce((a, b) => a + b);
      _currentIndex = null;
    });
  }

  void _setPremiumPosition(int index) {
    _apartmentBuilder.promotionBuilder.color = null;
    _apartmentBuilder.promotionBuilder.phrase = null;
    setState(() {
      _addColor = false;
      _currentIndex = index;
      _totalPrice = _promotionList[index + 2].price;
      _complexPrice = List<int>();
    });
  }

  void _closeScreen() {
    if (widget.imageList != null) {
      Navigator.pushAndRemoveUntil(
          context, FadeRoute(page: HomeScreen()), (route) => false);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildScreen() {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            child: Column(
              children: [
                PromotionCardMedium(
                  apartmentBuilder: _apartmentBuilder,
                  imageFile: widget.imageList,
                  promotionList: _promotionList,
                  addColor: _addColor,
                  changeColor: () {
                    setState(() {
                      _addColor = !_addColor;
                    });
                  },
                  changePhrase: () {
                    setState(() {
                      _addPhrase = !_addPhrase;
                    });
                  },
                  colorPicked: (int value) {
                    setState(() {
                      _apartmentBuilder.promotionBuilder.color = value;
                    });
                    _setBasicPosition(_promotionList[0].price);
                  },
                ),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _setPremiumPosition(index),
                      child: PromotionCardSmall(
                        promotionList: _promotionList,
                        index: index,
                        currentIndex: _currentIndex,
                      ),
                    );
                  },
                ),
                if (_totalPrice != 0)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32.0, 22.0, 32.0, 8.0),
                    child: GradientButton(
                      title: "Оплатить $_totalPrice₽",
                      maxWidth: double.infinity,
                      minHeight: 60.0,
                      borderRadius: 45.0,
                      onTap: () async {
                        setState(() => _startLoading = true);
                        await MakePayment.makePayment(
                          apartmentBuilder: _apartmentBuilder,
                          list: _promotionList,
                          imageList: widget.imageList,
                          price: _totalPrice,
                        );
                        _closeScreen();
                      },
                    ),
                  ),
                if (_apartmentBuilder.promotionBuilder.adWeight == null)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                      bottom: 42.0,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() => _startLoading = true);
                        await MakePayment.uploadWithoutPayment(
                          apartmentBuilder: _apartmentBuilder,
                          imageList: widget.imageList,
                        );
                        _closeScreen();
                      },
                      child: Text(
                        "Разместить без оплаты",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          AnimatedContainer(
            width: _addPhrase ? MediaQuery.of(context).size.width : 0,
            height: _addPhrase ? 690 : 0,
            duration: Duration(milliseconds: 1500),
            curve: Curves.fastOutSlowIn,
            child: PromotionPhrasePicker(
              promotionBuilder: _apartmentBuilder.promotionBuilder,
              addPhrase: _addPhrase,
              phrasePicked: (String value) {
                setState(() {
                  _apartmentBuilder.promotionBuilder.phrase = value;
                });
                _setBasicPosition(_promotionList[1].price);
              },
              changePhrase: () {
                setState(() => _addPhrase = !_addPhrase);
              },
            ),
          ),
        ],
      );
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBarStyle1(
            title: "Продвижение",
            onTapLeading: () => Navigator.pop(context),
            onTapAction: () {
              Navigator.pushAndRemoveUntil(
                  context, FadeRoute(page: HomeScreen()), (route) => false);
            },
          ),
          body: NetworkConnectivity(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: _buildScreen(),
            ),
          ),
        ),
        if (_startLoading == true) WaveIndicator(),
      ],
    );
  }
}
