class PromotionBuilder {
  int color;
  String phrase;
  bool isBigAd;
  int adWeight;

  PromotionBuilder();

  PromotionBuilder.fromMap(Map<String, dynamic> json)
      : color = json['color'],
        phrase = json['phrase'],
        isBigAd = json['isBigAd'],
        adWeight = json['adWeight'];

  @override
  String toString() {
    return '{color: $color, phrase: $phrase, isBigAd: $isBigAd, adWeight: $adWeight}';
  }
}

class Promotion {
  final int color;
  final String phrase;
  final bool isBigAd;
  final int adWeight;

  Promotion(PromotionBuilder promotionBuilder)
      : color = promotionBuilder.color,
        phrase = promotionBuilder.phrase,
        isBigAd = promotionBuilder.isBigAd,
        adWeight = promotionBuilder.adWeight;

  Map<String, dynamic> toMap() {
    return {
      "color": color,
      "phrase": phrase,
      "isBigAd": isBigAd,
      "adWeight": adWeight,
    };
  }
}
