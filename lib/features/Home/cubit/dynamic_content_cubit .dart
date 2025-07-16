import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dynamic_content_state.dart';

/// الكيوبت: مسؤول عن تغيير المحتوى تلقائيًا كل فترة
class DynamicContentCubit extends Cubit<DynamicContentState> {
  final int length;
  Timer? _timer;
  int _index = 0;

  DynamicContentCubit({required this.length})
    : super(const DynamicContentState(0)) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _index = (_index + 1) % length;
      emit(DynamicContentState(_index));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
