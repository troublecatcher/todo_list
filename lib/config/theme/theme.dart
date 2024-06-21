import 'package:flutter/material.dart';
import 'package:todo_list/config/theme/app_colors.dart';

ThemeData getLightTheme() {
  final lightThemeColors = LightThemeColors();
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: false,
    scaffoldBackgroundColor: lightThemeColors.backgroundPrimary,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 32,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
    disabledColor: lightThemeColors.labelDisabled,
    appBarTheme: AppBarTheme(
      backgroundColor: lightThemeColors.backgroundPrimary,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: AppColors.white,
    ),
    dividerColor: lightThemeColors.supportSeparator,
    colorScheme: ColorScheme.light(
      primary: AppColors.blue,
      secondary: AppColors.blue,
      background: lightThemeColors.backgroundPrimary,
      surface: lightThemeColors.backgroundElevated,
      tertiary: lightThemeColors.labelTertiary,
    ),
  );
}
