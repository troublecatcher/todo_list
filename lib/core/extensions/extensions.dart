import 'package:flutter/material.dart';
import 'package:todo_list/config/theme/custom_colors.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get _theme => Theme.of(this);

  TextTheme get textTheme => _theme.textTheme;

  ColorScheme get colorScheme => _theme.colorScheme;

  CustomColors get customColors {
    final customColors = _theme.extension<CustomColors>();
    assert(customColors != null, 'CustomColors not found in ThemeData');
    return customColors!;
  }
}
