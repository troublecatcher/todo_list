import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String get formattedDate => DateFormat('dd MMMM yyyy').format(this);

  String get formattedDateAndTime => DateFormat('dd.MM.yy HH:mm').format(this);
}
