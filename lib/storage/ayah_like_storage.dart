import 'package:hive/hive.dart';
import '../constants.dart';
import '../features/Home/presention/views/ayah_liked/model/ayah_like_model.dart';

class AyahLikeStorage {
  static const String _boxName = likedAyahs;

  /// فتح أو إنشاء البوكس
  static Future<Box<AyahLikeModel>> _openBox() async {
    return await Hive.openBox<AyahLikeModel>(_boxName);
  }

  /// حفظ آية محبوبة
  static Future<void> likeAyah(AyahLikeModel ayah) async {
    final box = await _openBox();
    await box.add(ayah);
  }

  /// حذف آية من المفضلة باستخدام index
  static Future<void> removeAyah(int index) async {
    final box = await _openBox();
    await box.deleteAt(index);
  }

  /// الحصول على كل الآيات المحفوظة
  static Future<List<AyahLikeModel>> getLikedAyahs() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// التأكد إذا كانت الآية محفوظة بالفعل
  static Future<bool> isAyahLiked(String surahName, int ayahNumber) async {
    final box = await _openBox();
    return box.values.any(
          (ayah) => ayah.surahName == surahName && ayah.ayahNumber == ayahNumber,
    );
  }

  /// حذف كل الآيات المحفوظة
  static Future<void> clearAllLikedAyahs() async {
    final box = await _openBox();
    await box.clear();
  }

  static Future<int?> getAyahIndex(String surahName, int ayahNumber) async {
    final box = await _openBox();
    final iterable = box.values;
    int i = 0;
    for (var a in iterable) {
      if (a.surahName == surahName && a.ayahNumber == ayahNumber) return i;
      i++;
    }
    return null;
  }

}
