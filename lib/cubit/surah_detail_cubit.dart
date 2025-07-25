import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/surah_detail_service.dart';
import 'surah_detail_state.dart';

class SurahDetailCubit extends Cubit<SurahDetailState> {
  final SurahDetailService service;

  SurahDetailCubit(this.service) : super(SurahDetailInitial());

  Future<void> getSurahAyahs(int surahNumber) async {
    emit(SurahDetailLoading());
    try {
      final ayahs = await service.fetchSurahAyahs(surahNumber);
      emit(SurahDetailLoaded(ayahs));
    } catch (e) {
      emit(SurahDetailError('فشل في تحميل الآيات'));
    }
  }
}
