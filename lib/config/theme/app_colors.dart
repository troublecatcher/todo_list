import 'package:flutter/material.dart';

abstract class AppColors {
  final Color supportSeparator;
  final Color supportOverlay;
  final Color labelPrimary;
  final Color labelSecondary;
  final Color labelTertiary;
  final Color labelDisabled;
  static const Color red = Color.fromRGBO(255, 59, 48, 1);
  static const Color green = Color.fromRGBO(52, 199, 89, 1);
  static const Color blue = Color.fromRGBO(0, 122, 255, 1);
  static const Color gray = Color.fromRGBO(142, 142, 147, 1);
  static const Color grayLight = Color.fromRGBO(209, 209, 214, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundElevated;

  AppColors({
    required this.supportSeparator,
    required this.supportOverlay,
    required this.labelPrimary,
    required this.labelSecondary,
    required this.labelTertiary,
    required this.labelDisabled,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundElevated,
  });
}

class LightThemeColors extends AppColors {
  LightThemeColors()
      : super(
          supportSeparator: const Color.fromRGBO(0, 0, 0, 0.2),
          supportOverlay: const Color.fromRGBO(0, 0, 0, 0.6),
          labelPrimary: const Color.fromRGBO(0, 0, 0, 1),
          labelSecondary: const Color.fromRGBO(0, 0, 0, 0.6),
          labelTertiary: const Color.fromRGBO(0, 0, 0, 0.3),
          labelDisabled: const Color.fromRGBO(0, 0, 0, 0.15),
          backgroundPrimary: const Color.fromRGBO(247, 246, 242, 1),
          backgroundSecondary: const Color.fromRGBO(255, 255, 255, 1),
          backgroundElevated: const Color.fromRGBO(255, 255, 255, 1),
        );
}

class DarkThemeColors extends AppColors {
  DarkThemeColors()
      : super(
          supportSeparator: const Color.fromRGBO(255, 255, 255, 0.2),
          supportOverlay: const Color.fromRGBO(0, 0, 0, 0.32),
          labelPrimary: const Color.fromRGBO(255, 255, 255, 1),
          labelSecondary: const Color.fromRGBO(255, 255, 255, 0.6),
          labelTertiary: const Color.fromRGBO(255, 255, 255, 0.4),
          labelDisabled: const Color.fromRGBO(255, 255, 255, 0.15),
          backgroundPrimary: const Color.fromRGBO(22, 22, 24, 1),
          backgroundSecondary: const Color.fromRGBO(37, 37, 40, 1),
          backgroundElevated: const Color.fromRGBO(60, 60, 63, 1),
        );
}
