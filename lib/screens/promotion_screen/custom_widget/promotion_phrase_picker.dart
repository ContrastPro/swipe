import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/global/style/app_colors.dart';
import 'package:swipe/model/promotion.dart';

class PromotionPhrasePicker extends StatelessWidget {
  static const List<String> _phrases = [
    "Подарок при покупке",
    "Возможен торг",
    "Квартира у моря",
    "В спальном районе",
    "Вам повезло с ценой",
    "Для большой семьи",
    "Се мейное гнёздышко",
    "Отдельная парковка",
  ];

  final PromotionBuilder promotionBuilder;
  final bool addPhrase;
  final VoidCallback changePhrase;
  final ValueChanged<String> phrasePicked;

  const PromotionPhrasePicker({
    Key key,
    @required this.promotionBuilder,
    @required this.phrasePicked,
    @required this.addPhrase,
    @required this.changePhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPhrases() {
      return ListView.builder(
        itemCount: _phrases.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => phrasePicked(_phrases[index]),
            child: Container(
              width: double.infinity,
              height: 50.0,
              margin: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 16.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: Colors.black.withAlpha(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _phrases[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black.withAlpha(165),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    width: 18.0,
                    height: 18.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45.0),
                      color: _phrases[index] == promotionBuilder.phrase
                          ? AppColors.accentColor
                          : Colors.black.withAlpha(40),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: AppColors.promotionCardShadow,
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            AnimatedOpacity(
              opacity: addPhrase ? 1.0 : 0.0,
              duration: Duration(
                milliseconds: addPhrase ? 1500 : 400,
              ),
              curve: Curves.easeInBack,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 25.0),
                  Text(
                    "Выбор фразы",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17.0,
                    ),
                  ),
                  SizedBox(height: 35.0),
                  _buildPhrases(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      top: 45.0,
                      right: 16.0,
                    ),
                    child: GradientButton(
                      title: "Подтвердить",
                      maxWidth: double.infinity,
                      minHeight: 50.0,
                      borderRadius: 10.0,
                      onTap: () => changePhrase(),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              opacity: addPhrase ? 1.0 : 0.0,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInBack,
              child: IconButton(
                padding: EdgeInsets.all(20.0),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                icon: Icon(Icons.close),
                onPressed: () => changePhrase(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
