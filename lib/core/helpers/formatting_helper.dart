import 'package:intl/intl.dart';

class FormattingHelper {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String formatDateAndTime(DateTime date) {
    return DateFormat('dd.MM.yy HH:mm').format(date);
  }
}
