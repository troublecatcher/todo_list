import 'package:flutter/material.dart';
import 'package:todo_list/config/theme/app_colors.dart';
import 'package:todo_list/config/theme/custom_colors.dart';

class AppTheme {
  static ThemeData getLightTheme() {
    final lightThemeColors = LightThemeColors();
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: _useMaterial3,
      scaffoldBackgroundColor: lightThemeColors.backgroundPrimary,
      textTheme: _textTheme,
      disabledColor: lightThemeColors.labelDisabled,
      appBarTheme: AppBarTheme(
        backgroundColor: lightThemeColors.backgroundPrimary,
      ),
      dividerColor: lightThemeColors.supportSeparator,
      colorScheme: ColorScheme.light(
        primary: const Color.fromRGBO(0, 122, 255, 1),
        onPrimary: Colors.white,
        secondary: const Color.fromRGBO(0, 122, 255, 1),
        surface: lightThemeColors.backgroundElevated,
        tertiary: lightThemeColors.labelTertiary,
      ),
      extensions: _extensions,
    );
  }

  static ThemeData getDarkTheme() {
    final darkThemeColors = DarkThemeColors();
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: _useMaterial3,
      scaffoldBackgroundColor: darkThemeColors.backgroundPrimary,
      textTheme: _textTheme,
      disabledColor: darkThemeColors.labelDisabled,
      appBarTheme: AppBarTheme(
        backgroundColor: darkThemeColors.backgroundPrimary,
      ),
      dividerColor: darkThemeColors.supportSeparator,
      colorScheme: ColorScheme.dark(
        primary: const Color.fromRGBO(0, 122, 255, 1),
        onPrimary: Colors.white,
        secondary: const Color.fromRGBO(0, 122, 255, 1),
        surface: darkThemeColors.backgroundSecondary,
        tertiary: darkThemeColors.labelTertiary,
        onSurface: darkThemeColors.labelPrimary,
      ),
      extensions: _extensions,
    );
  }

  // I believe this is not the best solution, I'm open to hear your opinion

  static bool get _useMaterial3 => false;

  static List<ThemeExtension> get _extensions => [
        CustomColors(
          red: const Color.fromRGBO(255, 59, 48, 1),
          orange: const Color.fromRGBO(252, 172, 111, 1),
          green: const Color.fromRGBO(52, 199, 89, 1),
          blue: const Color.fromRGBO(0, 122, 255, 1),
          grey: const Color.fromRGBO(142, 142, 147, 1),
          lightGrey: const Color.fromRGBO(209, 209, 214, 1),
          white: const Color.fromRGBO(255, 255, 255, 1),
        )
      ];

  static TextTheme get _textTheme => const TextTheme(
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
          fontSize: 18,
        ),
        labelMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      );
}
