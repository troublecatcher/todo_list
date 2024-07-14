import 'package:flutter/material.dart';

import '../../config/theme/app_theme/app_theme.dart';

extension ThemeExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get textTheme => _theme.textTheme;
  ColorScheme get colorScheme => _theme.colorScheme;

  CustomColors get customColors {
    final customColors = _theme.extension<CustomColors>();
    assert(customColors != null, 'CustomColors not found in ThemeData');
    return customColors!;
  }

  Color get scaffoldBackgroundColor => _theme.scaffoldBackgroundColor;
  Color get dividerColor => _theme.dividerColor;
  Color get disabledColor => _theme.disabledColor;
}
