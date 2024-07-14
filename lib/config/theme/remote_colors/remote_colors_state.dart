import 'package:flutter/material.dart';

sealed class RemoteColorsState {}

final class RemoteColorsInitial extends RemoteColorsState {}

final class RemoteColorsLoaded extends RemoteColorsState {
  final Color? importanceColorBasic;
  final Color? importanceColorLow;
  final Color? importanceColorImportant;

  RemoteColorsLoaded({
    required this.importanceColorBasic,
    required this.importanceColorLow,
    required this.importanceColorImportant,
  });
}
