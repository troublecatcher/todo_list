import 'package:flutter/material.dart';

sealed class RemoteColorsState {}

final class RemoteColorsInitial extends RemoteColorsState {}

final class RemoteColorsLoaded extends RemoteColorsState {
  final Color? basicColor;
  final Color? lowColor;
  final Color? importantColor;

  RemoteColorsLoaded({
    required this.basicColor,
    required this.lowColor,
    required this.importantColor,
  });
}
