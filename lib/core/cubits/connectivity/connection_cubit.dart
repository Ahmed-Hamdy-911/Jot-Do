import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../constants/app_constants.dart';
import '../../services/app_service.dart';
import 'connection_state.dart';

class ConnectionCubit extends Cubit<ConnectionStates> {
  final Connectivity _connectivity = Connectivity();
  final AppService appService = AppConstants.appService;

  late final StreamSubscription<ConnectivityResult> _connectivitySub;
  late final StreamSubscription<InternetStatus> _internetSub;
  Timer? _timeoutTimer;
  bool _wasDisconnected = false;

  ConnectionCubit() : super(ConnectionInitial()) {
    _connectivitySub = _connectivity.onConnectivityChanged
        .map(
          (results) =>
              results.isNotEmpty ? results.first : ConnectivityResult.none,
        )
        .listen(_onConnectivityChanged);
    ;

    _internetSub =
        InternetConnection().onStatusChange.listen(_onInternetStatusChanged);

    _checkInitialStatus();
  }

  void _onConnectivityChanged(ConnectivityResult result) {
    // log('Connectivity changed: $result');

    if (result == ConnectivityResult.none) {
      _timeoutTimer?.cancel();
      appService.isOnline = false;
      _wasDisconnected = true;
      _emitIfChanged(ConnectionDisconnected());
      return;
    }

    _timeoutTimer?.cancel();
    _timeoutTimer = Timer(const Duration(seconds: 5), () {
      if (!appService.isOnline) {
        _emitIfChanged(
            ConnectionTimeOut("Network available but no internet (timeout)"));
      }
    });

    if (_wasDisconnected) {
      _emitIfChanged(ConnectionReconnected());
      _wasDisconnected = false;
    }
  }

  void _onInternetStatusChanged(InternetStatus status) {
    // log('InternetStatus changed: $status');
    _timeoutTimer?.cancel();

    if (status == InternetStatus.connected) {
      appService.isOnline = true;
      _emitIfChanged(ConnectionConnected());
    } else {
      appService.isOnline = false;
      _emitIfChanged(ConnectionDisconnected());
    }

    debugPrint(appService.isOnline.toString());
  }

  Future<void> _checkInitialStatus() async {
    final hasInternet = await InternetConnection().hasInternetAccess;
    appService.isOnline = hasInternet;
    _wasDisconnected = !hasInternet;
    _emitIfChanged(
        hasInternet ? ConnectionConnected() : ConnectionDisconnected());
  }

  void _emitIfChanged(ConnectionStates newState) {
    if (state.runtimeType != newState.runtimeType) {
      emit(newState);
    }
  }

  @override
  Future<void> close() {
    _connectivitySub.cancel();
    _internetSub.cancel();
    _timeoutTimer?.cancel();
    return super.close();
  }
}
