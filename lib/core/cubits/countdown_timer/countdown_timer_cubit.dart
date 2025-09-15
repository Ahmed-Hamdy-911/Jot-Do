import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../services/countdown_timer_service.dart';
import 'countdown_timer_state.dart';

class CountdownTimerCubit extends Cubit<CountdownTimerState> {
  CountdownTimerCubit(this._timerService)
      : super(const CountdownTimerState(
            secondLeft: 0,
            isCompleted:
                true)); // initial state of the countdown timer cubit and no timer is running
  final CountdownTimerService _timerService;
  StreamSubscription<int>?
      _timerSubscription; // subscription to the timer stream of the countdown timer service

  void startTimer({required int fromSeconds}) {
    log('fromSeconds: $fromSeconds');
    _timerSubscription
        ?.cancel(); // cancel the previous timer if it is running to avoid multiple timers
    _timerService.startTimer(fromSeconds: fromSeconds); // start the timer
    _timerSubscription = _timerService.timerStream.listen((timeLeft) {
      emit(CountdownTimerState(
          secondLeft: timeLeft,
          isCompleted:
              timeLeft == 0)); // is completed(true) if the time left is 0
    }); // listen to the timer stream of the countdown timer service and emit the time left to the UI
  }

  void pauseTimer() => _timerService.pauseTimer(); // pause the timer
  void resumeTimer() => _timerService.resumeTimer(); // resume the timer
  void stopTimer() => _timerService.stopTimer(); // stop the timer
  void cancelTimer() => _timerService.cancelTimer(); // cancel the timer

  @override
  Future<void> close() {
    _timerSubscription?.cancel();
    _timerService.dispose();
    return super.close();
  }
}
