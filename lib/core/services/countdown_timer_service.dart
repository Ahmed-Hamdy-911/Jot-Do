// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerService {
  // generate stream numbers for timer(in seconds)
  final StreamController<int> _timerController =
      StreamController<int>.broadcast();
  // the stream of the timer that the cubit will listen to it and the UI also.
  Stream<int> get timerStream => _timerController.stream;
  // the timer itself that will run in the background.
  Timer? _timer;
  // the end time of the timer
  DateTime? _endTime;
  // the remaining time when the timer is paused
  int? _remainingWhenPaused;
  // the current time when the timer is paused or stopped (will be null when the timer is not running and true when the timer is running)
  bool get isTimerRunning => _timer != null;

  void startTimer({
    required int fromSeconds, // the time to start the timer from in seconds
  }) {
    _timer?.cancel(); // cancel the previous timer if it is running
    _remainingWhenPaused =
        null; // reset the remaining time when the timer is paused
    _endTime = DateTime.now()
        .add(Duration(seconds: fromSeconds)); // set the end time of the timer

    _emit(
        fromSeconds); // emit the current time left when the timer is started to send it to the UI and the cubit
    // start the timer in the background with a period of 1 second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final timeLeft = _currentTimeLeft();
      debugPrint("timeLeft: $timeLeft");
      if (timeLeft == 0) {
        _timer?.cancel(); // cancel the timer when the time is up
        _emit(
            0); // emit 0 when the time is up to send it to the UI and the cubit
      } else {
        _emit(
            timeLeft); // emit the current time left to send it to the UI and the cubit
      }
    });
  }

  void pauseTimer() {
    if (_timer == null) return; // return if the timer is not running yet
    _remainingWhenPaused =
        _currentTimeLeft(); // save the remaining time when the timer is paused
    _timer?.cancel(); // cancel the timer when the timer is paused
    _timer = null; // set the timer to null when the timer is paused
  }

  void resumeTimer() {
    if (_timer != null) return; // return if the timer is not running yet
    final remaining =
        _remainingWhenPaused!; // get the remaining time when the timer is paused
    if (remaining == null) return; // return if the remaining time is null
    startTimer(
        fromSeconds: remaining); // start the timer with the remaining time
    _remainingWhenPaused =
        null; // reset the remaining time when the timer is paused
    _endTime = DateTime.now().add(Duration(
        seconds: _remainingWhenPaused!)); // set the end time of the timer
  }

  void stopTimer() {
    _timer?.cancel(); // cancel the timer when the timer is stopped
    _timer = null; // set the timer to null when the timer is stopped
    _remainingWhenPaused =
        null; // reset the remaining time when the timer is paused
    _endTime = null; // reset the end time of the timer
  }

  void cancelTimer() {
    stopTimer();
    _emit(
        0); // emit 0 to send it to stream to send it to the UI and the cubit and reset the timer
  }

  int _currentTimeLeft() {
    if (_endTime == null) return 0; // return 0 if the end time is null
    final diffTime = _endTime!
        .difference(DateTime.now())
        .inSeconds; // get the difference between the end time and the current time in seconds
    return diffTime > 0
        ? diffTime
        : 0; // return the difference if it is greater than 0 else return 0(if the difference is negative it means the time is up and the timer should be canceled and reset the timer and return 0)
  }

  void _emit(int timeLeft) {
    if (!_timerController.isClosed)
      _timerController.add(
          timeLeft); // add the time left to the stream if the stream is not closed and the timer is running
  }

  void dispose() {
    _timer?.cancel();
    _timerController.close();
  } // dispose the timer and the stream
}
