import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FormattingHelper {
  static Future<void> init() async {
    await initializeDateFormatting();
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd MMMM yyyy').format(date);
  }

  static String formatDateAndTime(DateTime date) {
    return DateFormat('dd.MM.yy HH:mm').format(date);
  }
}
