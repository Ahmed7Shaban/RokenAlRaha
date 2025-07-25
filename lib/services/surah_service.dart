// lib/services/surah_service.dart
import 'package:dio/dio.dart';
import '../models/surah_model.dart';
import '../models/quran_response_model.dart';

class SurahService {
  final Dio _dio = Dio();
  final String _endpoint = 'http://api.alquran.cloud/v1/quran/ar.alafasy';

  Future<QuranResponse?> getAllSurahs() async {
    try {
      final response = await _dio.get(_endpoint);

      if (response.statusCode == 200 && response.data != null) {
        final quranResponse = QuranResponse.fromJson(response.data);
        return quranResponse;
      } else {
        throw Exception('📡 لم يتم الحصول على استجابة صحيحة من السيرفر');
      }
    } on DioError catch (dioError) {
      // معالجه اخطاء الشبكة
      throw Exception(
        '🌐 خطأ في الاتصال بالإنترنت: ${dioError.message}',
      );
    } catch (e) {
      throw Exception('⚠️ خطأ غير متوقع: ${e.toString()}');
    }
  }

  Future<SurahModel> fetchSurahByIndex(int surahIndex) async {
    final quranResponse = await getAllSurahs();
    if (quranResponse == null || quranResponse.surahs.isEmpty) {
      throw Exception("لا يوجد سور متاحة");
    }

    if (surahIndex < 0 || surahIndex >= quranResponse.surahs.length) {
      throw Exception("رقم السورة غير صالح");
    }

    return quranResponse.surahs[surahIndex];
  }

}
