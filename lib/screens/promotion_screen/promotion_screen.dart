import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_card_medium.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_card_small.dart';
import 'package:swipe/screens/promotion_screen/provider/promotion_provider.dart';

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
  int _currentIndex;

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
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          physics: BouncingScrollPhysics(),
          child: Consumer<PromotionNotifier>(
            builder: (context, promotionNotifier, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    child: PromotionCardMedium(
                      imageUrl: widget.imageList[0],
                    ),
                  ),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        child: PromotionCardSmall(
                          initialIndex: index,
                          currentIndex: _currentIndex,
                          promotionList: promotionNotifier.promotionList,
                        ),
                      );
                    },
                  ),
                  if (promotionNotifier.totalPrice != 0)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 22.0, 32.0, 8.0),
                      child: GradientButton(
                        title: "Оплатить ${promotionNotifier.totalPrice}₽",
                        maxWidth: double.infinity,
                        minHeight: 60.0,
                        borderRadius: 45.0,
                        onTap: () {},
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                      bottom: 42.0,
                    ),
                    child: GestureDetector(
                      onTap: () {},
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
              );
            },
          ),
        ),
      ),
    );
  }
}
