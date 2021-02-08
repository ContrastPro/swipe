class Subscription {
  final bool isActive;
  final String isActiveUntil; // Wil be DateTime

  Subscription({this.isActive, this.isActiveUntil});

  factory Subscription.fromMap(Map<String, dynamic> json) {
    return Subscription(
      isActive: json['isActive'],
      isActiveUntil: json['isActiveUntil'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "isActive": isActive,
      "isActiveUntil": isActiveUntil,
    };
  }

  @override
  String toString() {
    return '{isActive: $isActive, isActiveUntil: $isActiveUntil}';
  }
}
