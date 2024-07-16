part of 'connectivity_cubit.dart';

sealed class ConnectivityState {}

final class ConnectivityInitial extends ConnectivityState {}

final class ConnectivityOnline extends ConnectivityState {}

final class ConnectivityOffline extends ConnectivityState {}
