import 'package:hive/hive.dart';

import '../models/ayah_model.dart';

class QuranCacheHelper {
  static final Box _box = Hive.box('quranBox');

  /// حفظ سورة كاملة
  static Future<void> cacheSurah(int surahNumber, Map<String, dynamic> surahJson) async {
    print("📥 [cacheSurah] جاري حفظ سورة رقم $surahNumber في الكاش...");

    final cleanedMap = <String, dynamic>{
      for (var entry in surahJson.entries)
        entry.key: (entry.value is List)
            ? (entry.value as List).map((e) {
          if (e is Map) {
            return Map<String, dynamic>.from(e);
          } else {
            return e;
          }
        }).toList()
            : entry.value
    };

    print("📥 [cacheSurah] البيانات بعد التنظيف: $cleanedMap");
    await _box.put('surah_$surahNumber', cleanedMap);
    print("✅ [cacheSurah] تم حفظ السورة بنجاح ✅");
  }


  /// استرجاع سورة من الكاش
  static Map<String, dynamic>? getCachedSurah(int surahNumber) {
    print("📤 [getCachedSurah] محاولة استرجاع السورة رقم $surahNumber من الكاش");
    final data = _box.get('surah_$surahNumber');

    if (data == null) {
      print("❌ [getCachedSurah] لا يوجد بيانات محفوظة للكاش");
      return null;
    }

    try {
      final Map<String, dynamic> result = {};

      if (data is Map) {
        data.forEach((key, value) {
          if (value is List) {
            result[key.toString()] = value.map((item) {
              if (item is Map) {
                return Map<String, dynamic>.from(item);
              } else {
                print("⚠️ عنصر غير صحيح داخل القائمة: $item");
                throw Exception("❌ عنصر غير صحيح في القائمة");
              }
            }).toList();
          } else {
            result[key.toString()] = value;
          }
        });
        print("✅ [getCachedSurah] تم تحويل البيانات بنجاح: $result");
        return result;
      } else {
        print("❌ [getCachedSurah] البيانات ليست من النوع Map");
        return null;
      }
    } catch (e) {
      print("❌ [getCachedSurah] فشل في التحويل: $e");
      return null;
    }
  }



  /// هل السورة موجودة في الكاش؟
  static bool isSurahCached(int surahNumber) {
    return _box.containsKey('surah_$surahNumber');
  }

  static void cacheAyahs(int surahNumber, List<AyahModel> ayahs) {
    final box = Hive.box('quranBox');
    final key = 'ayahs_$surahNumber';
    final jsonList = ayahs.map((a) => a.toJson()).toList();
    box.put(key, jsonList);
  }

  // static List<AyahModel>? getCachedAyahs(int surahNumber) {
  //   final box = Hive.box('quranBox');
  //   final key = 'ayahs_$surahNumber';
  //   final jsonList = box.get(key);
  //   if (jsonList == null) return null;
  //
  //   return List<AyahModel>.from(
  //     jsonList.map((json) => AyahModel.fromJson(json)),
  //   );
  // }

/*  static List<AyahModel>? getCachedAyahs(int surahNumber) {
    final key = 'ayahs_$surahNumber';
    final jsonList = _box.get(key);

    if (jsonList is List) {
      return jsonList
          .map((json) => AyahModel.fromJson((json as Map).cast<String, dynamic>()))
          .toList();
    }
    return null;
  }*/
  static List<AyahModel>? getCachedAyahs(int surahNumber) {
    final key = 'ayahs_$surahNumber';
    final jsonList = _box.get(key);

    if (jsonList == null || jsonList is! List) return null;

    try {
      return jsonList.map<AyahModel>((json) {
        if (json is Map) {
          final map = Map<String, dynamic>.from(json.cast<String, dynamic>());
          return AyahModel.fromJson(map);
        } else {
          print('Invalid JSON item: $json');
          throw Exception('Invalid item in cache');
        }
      }).toList();
    } catch (e) {
      print('Error while parsing cached ayahs: $e');
      return null;
    }
  }


}
