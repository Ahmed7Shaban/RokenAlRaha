import 'package:dio/dio.dart';
import '../storage/hive_ayah_storage.dart';
import '../models/ayah_model.dart';

class AyahService {
  final Dio _dio = Dio();
  final String _endpoint = "http://api.alquran.cloud/v1/quran/ar.alafasy";

  final HiveAyahStorage _hiveStorage = HiveAyahStorage();

  Future<List<AyahModel>> fetchAyahsBySurahNumber(int surahNumber) async {
    // نحاول نجيب من الكاش أولاً
    final cached = await _hiveStorage.getCachedAyahs(surahNumber);
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    // لو مفيش، نجيب من API
    final response = await _dio.get(_endpoint);
    if (response.statusCode == 200) {
      final allSurahs = response.data['data']['surahs'] as List;
      final surah = allSurahs.firstWhere((s) => s['number'] == surahNumber);
      final ayahs = (surah['ayahs'] as List)
          .map((a) => AyahModel.fromJson(a))
          .toList();

      // نخزنهم في الكاش
      await _hiveStorage.cacheAyahs(surahNumber, ayahs);

      return ayahs;
    } else {
      throw Exception("فشل في تحميل الآيات");
    }
  }
}
