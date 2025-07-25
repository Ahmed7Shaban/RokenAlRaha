// lib/cubits/surah_cubit/surah_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'surah_state.dart';
import '../../../services/surah_service.dart';

class SurahCubit extends Cubit<SurahState> {
  final SurahService surahService;

  SurahCubit(this.surahService) : super(SurahInitial());

  Future<void> fetchSurahs() async {
    emit(SurahLoading());
    try {
      final response = await surahService.getAllSurahs();
      final surahs = response?.surahs;

      if (surahs == null || surahs.isEmpty) {
        emit(SurahError("❗لم يتم العثور على أي سور."));
      } else {
        emit(SurahLoaded(surahs));
      }
    } catch (e) {
      emit(SurahError("❌ حدث خطأ أثناء جلب السور:\n${e.toString()}"));
    }
  }
}
