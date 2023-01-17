import 'package:intl/intl.dart';

class Format {
  static String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNegative);

    return '${formatted}h';
  }

  static String inHour(DateTime date) {
    final time = DateFormat.Hm().format(date);
    return time;
  }

  static String date(DateTime date) {
    return "${DateFormat.d().format(date)} ${DateFormat.MMM().format(date)} ${DateFormat.y().format(date)}";
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }
}
