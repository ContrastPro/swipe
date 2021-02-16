import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_apartment_item.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_apartment_item_big.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_cad_big.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_cad_medium.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_card_small.dart';

class PromotionScreen extends StatefulWidget {
  final ApartmentBuilder apartmentBuilder;
  final List<String> imageList;

  const PromotionScreen({
    Key key,
    this.apartmentBuilder,
    this.imageList,
  }) : super(key: key);

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Продвижение",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: NetworkConnectivity(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              PromotionCardMedium(
                leading: PromotionApartmentItem(
                  imageUrl: widget.imageList[0],
                  isColored: true,
                ),
                title: "Выделить цветом",
                subTitle: "Цветовая палитра на выбор из наших цветов",
                price: "199",
                efficiency: 0.40,
              ),
              PromotionCardMedium(
                leading: PromotionApartmentItem(
                  imageUrl: widget.imageList[0],
                  isPhrase: true,
                ),
                title: "Добавить фразу",
                subTitle: "Выбор из 10 фраз написаных нами",
                price: "249",
                efficiency: 0.60,
              ),
              PromotionCardBig(
                leading: PromotionApartmentItemBig(
                  imageUrl: widget.imageList[0],
                  isPhrase: true,
                ),
                title: "Большое объявление",
                price: "299",
                efficiency: 1,
              ),
              PromotionCardSmall(
                leading: Image.asset("assets/images/promotion_1.png"),
                title: "Поднять объявление",
                price: "399",
                efficiency: 1,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF65DED5),
                    Color(0xFF75FADB),
                  ],
                ),
              ),
              PromotionCardSmall(
                leading: Image.asset("assets/images/promotion_3.png"),
                title: "Турбо",
                price: "499",
                efficiency: 1,
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFFF9137),
                    Color(0xFFFF231F),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
