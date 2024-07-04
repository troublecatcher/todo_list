import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfo(this._connectivity);

  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) return false;
    return true;
  }

  Stream<bool> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((connectivityResult) {
      if (connectivityResult.contains(ConnectivityResult.none)) return false;
      return true;
    });
  }
}
