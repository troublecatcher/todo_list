import 'package:flutter/material.dart';

class SnackbarManager {
  static show({
    required BuildContext context,
    required String title,
    required Color color,
    required Duration duration,
  }) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          dismissDirection: DismissDirection.none,
          content: Align(
            alignment: Alignment.center,
            child: Text(title),
          ),
          backgroundColor: color,
          duration: duration,
        ),
      );

  static hide(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
