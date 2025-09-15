import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'connection_state.dart';

class ConnectionCubit extends Cubit<ConnectionStates> {
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> _subscription;

  DateTime? _lastCheckTime;
  bool _wasDisconnected = false;
  bool _lastCheckResult = false;
  Timer? _timer;
  ConnectionCubit() : super(ConnectionInitial()) {
    _subscription = _connectivity.onConnectivityChanged
        .map(
          (results) =>
              results.isNotEmpty ? results.first : ConnectivityResult.none,
        )
        .listen(_onResult);
    _checkInitialStatus();
    _timer =
        Timer.periodic(const Duration(seconds: 5), (_) => checkConnection());
  }

  void _onResult(ConnectivityResult result) {
    ConnectionStates newState;
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      if (_wasDisconnected) {
        newState = ConnectionReconnected();
        _wasDisconnected = false;
      } else {
        newState = ConnectionConnected();
      }
    } else {
      newState = ConnectionDisconnected();
      _wasDisconnected = true;
    }
    if (state.runtimeType != newState.runtimeType) {
      emit(newState);
    }
  }

  Future<bool> checkConnection() async {
    if (_lastCheckTime != null &&
        DateTime.now().difference(_lastCheckTime!) <
            const Duration(seconds: 5)) {
      return _lastCheckResult;
    }

    final testUrls = [
      Uri.parse("https://clients3.google.com/generate_204"),
      Uri.parse("https://www.gstatic.com/generate_204"),
      Uri.parse("https://www.google.com"),
    ];

    for (final url in testUrls) {
      try {
        final request =
            await HttpClient().getUrl(url).timeout(const Duration(seconds: 2));
        final response =
            await request.close().timeout(const Duration(seconds: 2));

        if (response.statusCode == 204 || response.statusCode == 200) {
          _lastCheckTime = DateTime.now();
          _lastCheckResult = true;
          debugPrint("✅ Internet available via ${url.host}");
          return true;
        }
      } on SocketException {
        continue;
      } on TimeoutException {
        continue;
      } catch (e) {
        continue;
      }
    }

    debugPrint("❌ No internet connection");
    if (state is! ConnectionTimeOut && state is! ConnectionDisconnected) {
      emit(ConnectionTimeOut("No internet connection"));
    }
    _lastCheckTime = DateTime.now();
    _lastCheckResult = false;
    return false;
  }

  Future<void> _checkInitialStatus() async {
    final result = await Connectivity().checkConnectivity();
    final hasConnection =
        result.isNotEmpty && result.first != ConnectivityResult.none;
    final newState =
        hasConnection ? ConnectionConnected() : ConnectionDisconnected();
    if (state.runtimeType != newState.runtimeType) {
      emit(newState);
    }
    _wasDisconnected = !hasConnection;
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    _timer?.cancel();
    return super.close();
  }
}
