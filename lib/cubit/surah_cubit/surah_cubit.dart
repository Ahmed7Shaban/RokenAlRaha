
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/hive_quran_storage.dart';
import 'surah_state.dart';
import '../../../services/surah_service.dart';

class SurahCubit extends Cubit<SurahState> {
  final SurahService surahService;

  SurahCubit(this.surahService) : super(SurahInitial());

  Future<void> fetchSurahs() async {
    emit(SurahLoading());

    try {
      // جلب السور من الكاش أولًا
      final cachedSurahs = HiveQuranStorage.getCachedSurahs();
      if (cachedSurahs.isNotEmpty) {
        emit(SurahLoaded(cachedSurahs));
      }

      // بعدين نجرب نجيبها من الـ API لتحديث البيانات
      final response = await surahService.getAllSurahs();
      final surahs = response?.surahs;

      if (surahs == null || surahs.isEmpty) {
        if (cachedSurahs.isEmpty) {
          emit(SurahError("❗لم يتم العثور على أي سور."));
        }
        return;
      }

      // تحديث الكاش
      HiveQuranStorage.cacheSurahs(surahs);
      emit(SurahLoaded(surahs));
    } catch (e) {
      if (state is! SurahLoaded) {
        emit(SurahError("❌ حدث خطأ أثناء جلب السور:\n${e.toString()}"));
      }
    }
  }
}
