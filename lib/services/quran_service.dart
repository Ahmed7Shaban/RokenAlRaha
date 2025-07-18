// lib/services/quran_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/surah_model.dart';

class QuranService {
  static Future<List<SurahModel>> fetchSurahs() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/quran/quran-uthmani'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List surahJsonList = jsonData['data']['surahs'];
      return surahJsonList.map((s) => SurahModel.fromJson(s)).toList();
    } else {
      throw Exception('فشل في تحميل السور');
    }
  }
}
