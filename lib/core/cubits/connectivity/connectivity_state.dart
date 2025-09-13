abstract class ConnectivityStates {}

class ConnectivityInitial extends ConnectivityStates {}

class ConnectivityLoading extends ConnectivityStates {}

class ConnectivityConnected extends ConnectivityStates {}

class ConnectivityReconnected extends ConnectivityStates {}

class ConnectivityDisconnected extends ConnectivityStates {}

class ConnectivityError extends ConnectivityStates {
  final String message;
  ConnectivityError(this.message);
}
