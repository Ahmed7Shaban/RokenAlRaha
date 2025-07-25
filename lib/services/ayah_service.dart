import 'package:dio/dio.dart';
import '../models/ayah_model.dart';

class AyahService {
  final Dio _dio = Dio();
  final String _endpoint = "http://api.alquran.cloud/v1/quran/ar.alafasy";

  Future<List<AyahModel>> fetchAyahsBySurahNumber(int surahNumber) async {
    final response = await _dio.get(_endpoint);
    if (response.statusCode == 200) {
      final allSurahs = response.data['data']['surahs'] as List;
      final surah = allSurahs.firstWhere((s) => s['number'] == surahNumber);
      return (surah['ayahs'] as List)
          .map((a) => AyahModel.fromJson(a))
          .toList();
    } else {
      throw Exception("فشل في تحميل الآيات");
    }
  }
}
