import 'package:dio/dio.dart';
import '../helpers/hive_quran_storage.dart';
import '../models/surah_model.dart';
import '../models/quran_response_model.dart';

class SurahService {
  final Dio _dio = Dio();
  final String _endpoint = 'http://api.alquran.cloud/v1/quran/ar.alafasy';

  final HiveQuranStorage _hiveStorage = HiveQuranStorage(); // ✅

  Future<QuranResponse?> getAllSurahs() async {
    try {
      print('🔍 SurahService: محاولة استرجاع السور من Hive...');
      final cachedSurahs = await HiveQuranStorage.getCachedSurahs();

      if (cachedSurahs != null && cachedSurahs.isNotEmpty) {
        print('📦 SurahService: استرجاع السور من Hive بنجاح.');
        return QuranResponse(surahs: cachedSurahs);
      }

      print('🌐 SurahService: لا توجد سور في Hive → تحميل من الإنترنت...');
      final response = await _dio.get(_endpoint);

      if (response.statusCode == 200 && response.data != null) {
        final quranResponse = QuranResponse.fromJson(response.data);

        // حفظ السور بعد التحميل
        await HiveQuranStorage.cacheSurahs(quranResponse.surahs);

        print('💾 SurahService: تم تحميل وتخزين السور في Hive.');
        return quranResponse;
      } else {
        print('❌ SurahService: استجابة غير صحيحة من API');
        throw Exception('لم يتم الحصول على استجابة صحيحة من السيرفر');
      }
    } on DioError catch (dioError) {
      print('🌐 SurahService: خطأ في الاتصال بالإنترنت: ${dioError.message}');
      throw Exception('خطأ في الاتصال بالإنترنت: ${dioError.message}');
    } catch (e) {
      print('⚠️ SurahService: خطأ غير متوقع: ${e.toString()}');
      throw Exception('خطأ غير متوقع: ${e.toString()}');
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
