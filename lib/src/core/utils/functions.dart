import 'package:intl/intl.dart';

class Functions {
  static String formatDate(String isoString) {
    DateTime date = DateTime.parse(isoString);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }
}
