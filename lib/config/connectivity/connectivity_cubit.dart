import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:todo_list/config/connectivity/connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  ConnectivityResult previousState = ConnectivityResult.none;

  ConnectivityCubit() : super(ConnectivityInitial()) {
    _init();
  }

  void _init() {
    _subscription = Connectivity().onConnectivityChanged.listen(
      (results) {
        if (results.contains(ConnectivityResult.none)) {
          if (state is ConnectivityInitial) {
            emit(ConnectivityOffline());
          }
        }
        if (results.contains(ConnectivityResult.wifi) ||
            results.contains(ConnectivityResult.mobile) ||
            results.contains(ConnectivityResult.other) ||
            results.contains(ConnectivityResult.ethernet) ||
            results.contains(ConnectivityResult.vpn)) {
          if (state is ConnectivityOffline) {
            emit(ConnectivityOnline());
            emit(ConnectivityInitial());
          }
        }
      },
    );
  }

  // ConnectivityResult _mapResultsToState(List<ConnectivityResult> results) {
  //   if (results.contains(ConnectivityResult.none)) {
  //     return ConnectivityResult.none;
  //   }
  //   // Assuming ConnectivityResult.none is the only case indicating no connection
  //   return results.firstWhere((result) => result != ConnectivityResult.none,
  //       orElse: () => ConnectivityResult.none);
  // }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
