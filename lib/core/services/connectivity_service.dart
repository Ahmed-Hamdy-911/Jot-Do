import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivity.onConnectivityChanged.map(
        (results) =>
            results.isNotEmpty ? results.first : ConnectivityResult.none,
      );
}
