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
      (results) async {
        if (results.contains(ConnectivityResult.none)) {
          if (state is ConnectivityInitial) emit(ConnectivityOffline());
        }
        if (results.contains(ConnectivityResult.wifi) ||
            results.contains(ConnectivityResult.mobile)) {
          if (state is ConnectivityOffline) {
            emit(ConnectivityOnline());
            await Future<void>.delayed(const Duration(seconds: 3));
            emit(ConnectivityInitial());
          }
        }
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
