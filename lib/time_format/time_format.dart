import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeFormat {
  TimeFormat._();

  static int _calculateDifference(DateTime date) {
    final DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  static String buildTime(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();

    if (_calculateDifference(dateTime) == 0) {
      return "Сегодня в ${DateFormat('hh:mm').format(dateTime)}";
    } else if (_calculateDifference(dateTime) == -1) {
      return "Вчера в ${DateFormat('hh:mm').format(dateTime)}";
    } else {
      return "${DateFormat('dd MMMM').format(dateTime)}";
    }
  }
}
