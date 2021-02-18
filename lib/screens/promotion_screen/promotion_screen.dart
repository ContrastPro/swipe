import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_card_medium.dart';
import 'package:swipe/screens/promotion_screen/custom_widget/promotion_phrase_picker.dart';
import 'package:swipe/screens/promotion_screen/model/promotion_card.dart';

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
  ApartmentBuilder _apartmentBuilder;
  List<PromotionCard> _promotionList;

  bool _addColor = false;
  bool _addPhrase = false;

  @override
  void initState() {
    _apartmentBuilder = widget.apartmentBuilder;
    _promotionList = PromotionCard.promotionList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildScreen() {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: PromotionCardMedium(
                  promotionBuilder: _apartmentBuilder.promotionBuilder,
                  imageUrl: widget.imageList[0],
                  promotionList: _promotionList,
                  addColor: _addColor,
                  changeColor: () {
                    setState(() => _addColor = !_addColor);
                  },
                  changePhrase: () {
                    setState(() => _addPhrase = !_addPhrase);
                  },
                  colorPicked: (int value) {
                    setState(() {
                      _apartmentBuilder.promotionBuilder.color = value;
                    });
                  },
                ),
              ),
              /*ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: PromotionCardSmall(index: index),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 22.0, 32.0, 8.0),
                child: GradientButton(
                  title: "Оплатить ${promotionNotifier.getPrice}₽",
                  maxWidth: double.infinity,
                  minHeight: 60.0,
                  borderRadius: 45.0,
                  onTap: () {
                    promotionNotifier.makePayment(apartmentBuilder);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 32.0,
                  bottom: 42.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    promotionNotifier.addWithoutPayment(apartmentBuilder);
                  },
                  child: Text(
                    "Разместить без оплаты",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),*/
            ],
          ),
          AnimatedContainer(
            width: _addPhrase ? MediaQuery.of(context).size.width : 0,
            height: _addPhrase ? 680 : 0,
            duration: Duration(milliseconds: 1500),
            curve: Curves.fastOutSlowIn,
            child: PromotionPhrasePicker(
              promotionBuilder: _apartmentBuilder.promotionBuilder,
              addPhrase: _addPhrase,
              changePhrase: () {
                setState(() => _addPhrase = !_addPhrase);
              },
              phrasePicked: (String value) {
                setState(() {
                  _apartmentBuilder.promotionBuilder.phrase = value;
                });
              },
            ),
          ),
        ],
      );
    }

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
          child: _buildScreen(),
        ),
      ),
    );
  }
}
