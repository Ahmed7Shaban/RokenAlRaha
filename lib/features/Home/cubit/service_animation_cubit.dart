import 'package:flutter_bloc/flutter_bloc.dart';

import 'service_animation_state.dart';

class ServiceAnimationCubit extends Cubit<ServiceAnimationState> {
  ServiceAnimationCubit() : super(ServiceAnimationState([]));

  void showCard(int index) async {
    await Future.delayed(Duration(milliseconds: index * 120)); // تأخير تدريجي
    emit(ServiceAnimationState([...state.visibleIndexes, index]));
  }

  void reset() {
    emit(ServiceAnimationState([]));
  }
}
