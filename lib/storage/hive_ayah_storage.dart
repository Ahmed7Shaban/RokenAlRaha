import 'package:hive/hive.dart';
import '../constants.dart';
import '../models/ayah_model.dart';

class HiveAyahStorage {
  static const String _boxPrefix = ayahs;

  Future<void> cacheAyahs(int surahNumber, List<AyahModel> ayahs) async {
    final box = await Hive.openBox('ayahsBox-$surahNumber');

    // نخزنهم كلهم في مفتاح واحد كـ List<Map>
    await box.put('ayahs', ayahs.map((e) => e.toJson()).toList());

    await box.close();
  }
  Future<List<AyahModel>?> getCachedAyahs(int surahNumber) async {
    final box = await Hive.openBox('ayahsBox-$surahNumber');
    final cached = box.get('ayahs');
    await box.close();

    if (cached != null && cached is List) {
      try {
        return cached
            .map((e) => AyahModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      } catch (e) {
        print("❌ خطأ في تحويل البيانات من الكاش: $e");
      }
    }

    return null;
  }

  // Future<List<AyahModel>> getCachedAyahs(int surahNumber) async {
  //   final box = await Hive.openBox<AyahModel>('$_boxPrefix-$surahNumber');
  //   final data = box.values.toList();
  //   await box.close();
  //   return data;
  // }

  Future<bool> hasCachedAyahs(int surahNumber) async {
    final box = await Hive.openBox('ayahsBox-$surahNumber');
    final hasData = box.containsKey('ayahs');
    await box.close();
    return hasData;
  }
}
