import 'package:dio/dio.dart';

class SurahDetailService {
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> fetchSurahAyahs(int surahNumber) async {
    final response = await dio.get(
      'http://api.alquran.cloud/v1/surah/$surahNumber/quran-uthmani',
    );
    final data = response.data['data']['ayahs'] as List;
    return data.cast<Map<String, dynamic>>();
  }
}
