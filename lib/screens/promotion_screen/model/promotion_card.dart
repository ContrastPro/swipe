class PromotionCard {
  final String image;
  final String title;
  final String subTitle;
  final int price;
  final double efficiency;

  PromotionCard({
    this.image,
    this.title,
    this.subTitle,
    this.price,
    this.efficiency,
  });

  static List<PromotionCard> get promotionList => _promotionList;

  static List<PromotionCard> _promotionList = [
    PromotionCard(
      title: "Выделить цветом",
      subTitle: "Цветовая палитра на выбор из наших цветов",
      price: 199,
      efficiency: 0.40,
    ),
    PromotionCard(
      title: "Добавить фразу",
      subTitle: "Выбор из 10 фраз написаных нами",
      price: 249,
      efficiency: 0.60,
    ),
    PromotionCard(
      image: "assets/images/promotion_1.png",
      title: "Большое объявление",
      price: 299,
      efficiency: 1,
    ),
    PromotionCard(
      image: "assets/images/promotion_2.png",
      title: "Поднять объявление",
      price: 399,
      efficiency: 1,
    ),
    PromotionCard(
      image: "assets/images/promotion_3.png",
      title: "Турбо",
      price: 499,
      efficiency: 1,
    ),
  ];
}
