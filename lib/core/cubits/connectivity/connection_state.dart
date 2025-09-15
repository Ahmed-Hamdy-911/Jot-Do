abstract class ConnectionStates {}

class ConnectionInitial extends ConnectionStates {}

class ConnectionLoading extends ConnectionStates {}

class ConnectionConnected extends ConnectionStates {}

class ConnectionReconnected extends ConnectionStates {}

class ConnectionTimeOut extends ConnectionStates {
  final String message;
  ConnectionTimeOut(this.message);
}

class ConnectionDisconnected extends ConnectionStates {}

class ConnectionError extends ConnectionStates {
  final String message;
  ConnectionError(this.message);
}
