import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: const Color.fromRGBO(247, 246, 242, 1),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(247, 246, 242, 1),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(0, 122, 255, 1),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 32,
    ),
  ),
  // colorScheme: const ColorScheme(
  //   brightness: Brightness.light,
  //   primary: Color.fromRGBO(0, 122, 255, 1),
  //   onPrimary: Colors.transparent,
  //   secondary: Colors.transparent,
  //   onSecondary: Colors.transparent,
  //   error: Colors.transparent,
  //   onError: Colors.transparent,
  //   background: Colors.transparent,
  //   onBackground: Colors.transparent,
  //   surface: Colors.transparent,
  //   onSurface: Colors.transparent,
  // ),
);
