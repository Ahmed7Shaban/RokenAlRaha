import 'package:flutter_bloc/flutter_bloc.dart';
import 'action_bottom_state.dart';

class ActionBottomCubit extends Cubit<ActionBottomState> {
  ActionBottomCubit() : super(ActionBottomState.initial());

  void toggleLike() {
    emit(state.copyWith(isLiked: !state.isLiked));
  }

}
