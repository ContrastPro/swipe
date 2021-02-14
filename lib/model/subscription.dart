class Subscription {
  final String isActiveUntil;

  Subscription({this.isActiveUntil});

  factory Subscription.fromMap(Map<String, dynamic> json) {
    return Subscription(
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
