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

  static String formatTime(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();

    if (_calculateDifference(dateTime) == 0) {
      return "Сегодня в ${DateFormat('Hm', 'ru').format(dateTime)}";
    } else if (_calculateDifference(dateTime) == -1) {
      return "Вчера в ${DateFormat('Hm', 'ru').format(dateTime)}";
    } else {
      return "${DateFormat('dd MMMM', 'ru').format(dateTime)}";
    }
  }

  // Messages

  static int compareDates(Timestamp timestamp){
    return _calculateDifference(timestamp.toDate());
  }

  static String formatDateMessage(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    return "${DateFormat('d MMMM', 'ru').format(dateTime)}";
  }

  static String formatTimeMessage(Timestamp timestamp) {
    final DateTime dateTime = timestamp.toDate();
    return "${DateFormat('Hm', 'ru').format(dateTime)}";
  }
}
