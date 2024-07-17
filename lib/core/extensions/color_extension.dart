import 'package:flutter/widgets.dart';

extension ColorExtension on Color {
  static Color? parse(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    final buffer = StringBuffer();
    if (colorString.length == 6 || colorString.length == 7) buffer.write('ff');
    buffer.write(colorString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
