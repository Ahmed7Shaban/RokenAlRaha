import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'masbaha_state.dart';

class MasbahaCubit extends Cubit<MasbahaState> {
  MasbahaCubit() : super(MisbahaInitial());

  Timer? _timer;
  int _count = 0;
  int _seconds = 0;

  void increment() {
    _count++;
    _startTimerIfNeeded();
    _emitState();
  }

  void decrement() {
    if (_count > 0) {
      _count--;
      _emitState();
    }
  }

  void reset() {
    _count = 0;
    _seconds = 0;
    _timer?.cancel();
    _timer = null;
    _emitState();
  }

  void _startTimerIfNeeded() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _seconds++;
      _emitState();
    });
  }

  void _emitState() {
    emit(MisbahaUpdated(
      count: _count,
      seconds: _seconds,
      isMilestone: _count != 0 && _count % 33 == 0,
    ));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
