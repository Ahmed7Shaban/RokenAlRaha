import 'package:flutter_bloc/flutter_bloc.dart';
import 'ayah_state.dart';
import '../../services/ayah_service.dart';

class AyahCubit extends Cubit<AyahState> {
  final AyahService _ayahService;

  AyahCubit(this._ayahService) : super(AyahInitial());

  Future<void> fetchAyahsBySurahNumber(int surahNumber) async {
    emit(AyahLoading());
    try {
      final ayahs = await _ayahService.fetchAyahsBySurahNumber(surahNumber);
      emit(AyahLoaded(ayahs));
    } catch (e) {
      emit(AyahError(e.toString()));
    }
  }
}
