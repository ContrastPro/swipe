class PhoneFormat {
  PhoneFormat._();

  static String formatPhone({String phone}) {
    if (!phone.contains("+")) {
      return "+$phone";
    }
    return phone;
  }
}
