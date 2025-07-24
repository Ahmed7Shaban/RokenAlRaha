import 'package:dio/dio.dart';
import '../models/surah_model.dart';

class QuranService {
  final Dio _dio = Dio();
  final String _endpoint = 'http://api.alquran.cloud/v1/quran/ar.alafasy';

  Future<List<SurahModel>> fetchAllSurahs() async {
    try {
      final response = await _dio.get(_endpoint);

      if (response.statusCode == 200 && response.data['data'] != null) {
        final List surahsJson = response.data['data']['surahs'];
        return surahsJson.map((json) => SurahModel.fromJson(json)).toList();
      } else {
        throw Exception('فشل تحميل السور: استجابة غير متوقعة من الخادم');
      }
    } catch (e) {
      throw Exception('حدث خطأ أثناء تحميل السور: $e');
    }
  }
}
