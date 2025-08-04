// lib/core/storage/hive_quran_storage.dart

import 'package:hive/hive.dart';
import '../../models/surah_model.dart';

class HiveQuranStorage {
  static const _surahBoxName = 'surahsBox';

  static List<SurahModel> getCachedSurahs() {
    final box = Hive.box<SurahModel>(_surahBoxName);
    return box.values.toList();
  }

  static Future<void> cacheSurahs(List<SurahModel> surahs) async {
    final box = Hive.box<SurahModel>(_surahBoxName);
    await box.clear(); // تقدر تستبدله بتحديث فردي حسب ID
    for (var i = 0; i < surahs.length; i++) {
      await box.put(i, surahs[i]);
    }
  }
}
