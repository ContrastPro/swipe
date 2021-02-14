class Promotion {
  final String isActiveUntil;

  Promotion({this.isActiveUntil});

  factory Promotion.fromMap(Map<String, dynamic> json) {
    return Promotion(
      isActiveUntil: json['isActiveUntil'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "isActiveUntil": isActiveUntil ?? "13.02.2022",
    };
  }

  @override
  String toString() {
    return '{isActiveUntil: $isActiveUntil}';
  }
}