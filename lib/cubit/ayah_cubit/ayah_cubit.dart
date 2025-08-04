import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/hive_ayah_storage.dart';
import 'ayah_state.dart';
import '../../services/ayah_service.dart';

class AyahCubit extends Cubit<AyahState> {
  final AyahService _ayahService;
  final HiveAyahStorage _hiveStorage = HiveAyahStorage(); // ✅ لازم نستخدم instance

  AyahCubit(this._ayahService) : super(AyahInitial());

  Future<void> fetchAyahsBySurahNumber(int surahNumber) async {
    emit(AyahLoading());

    try {
      final hasCache = await _hiveStorage.hasCachedAyahs(surahNumber);

      if (hasCache) {
        final cachedAyahs = await _hiveStorage.getCachedAyahs(surahNumber);
        if (cachedAyahs != null && cachedAyahs.isNotEmpty) {
          debugPrint('✅ تم جلب الآيات من الكاش');
          emit(AyahLoaded(cachedAyahs));
        } else {
          debugPrint('❌ الكاش موجود لكن فاضي أو غير صالح');
          emit(AyahError("فشل في تحميل الآيات من الكاش"));
        }
      } else {
        debugPrint('🌐 لا يوجد كاش - تحميل من الإنترنت');
        final ayahs = await _ayahService.fetchAyahsBySurahNumber(surahNumber);
        await _hiveStorage.cacheAyahs(surahNumber, ayahs);
        emit(AyahLoaded(ayahs));
      }
    } catch (e) {
      emit(AyahError("خطأ أثناء تحميل الآيات: ${e.toString()}"));
    }
  }
}
