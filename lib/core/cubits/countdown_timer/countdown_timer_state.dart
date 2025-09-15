class CountdownTimerState {
  final int secondLeft;
  final bool? isPaused;
  final bool? isRunning;
  final bool isCompleted;
  const CountdownTimerState({
    required this.secondLeft,
    this.isPaused,
    this.isRunning,
    required this.isCompleted,
  });
}
