import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../services/connectivity_service.dart';
import 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityStates> {
  final ConnectivityService _connectivityService;
  StreamSubscription<ConnectivityResult>? _subscription;

  bool _wasDisconnected = false;
  ConnectivityCubit(this._connectivityService) : super(ConnectivityInitial()) {
    _subscription = _connectivityService.connectivityStream.listen(_onResult);
    _checkInitialStatus();
  }

  void _onResult(ConnectivityResult result) {
    ConnectivityStates newState;
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      if (_wasDisconnected) {
        newState = ConnectivityReconnected();
        _wasDisconnected = false;
      } else {
        newState = ConnectivityConnected();
      }
    } else {
      newState = ConnectivityDisconnected();
      _wasDisconnected = true;
    }
    if (state.runtimeType != newState.runtimeType) {
      emit(newState);
    }
  }

  Future<void> _checkInitialStatus() async {
    final result = await Connectivity().checkConnectivity();
    final hasConnection =
        result.isNotEmpty && result.first != ConnectivityResult.none;
    final newState =
        hasConnection ? ConnectivityConnected() : ConnectivityDisconnected();
    if (state.runtimeType != newState.runtimeType) {
      emit(newState);
    }
    _wasDisconnected = !hasConnection;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
