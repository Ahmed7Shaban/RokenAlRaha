import 'package:hive/hive.dart';

import '../features/Home/presention/views/AllAzkar/views/MyAzkar/model/zikr_model.dart';

class ZikrService {
  static const String _boxName = 'azkarBox';

  /// افتح البوكس
  static Future<Box<ZikrModel>> _openBox() async {
    return await Hive.openBox<ZikrModel>(_boxName);
  }

  /// أضف زكر جديد
  static Future<void> addZikr(ZikrModel zikr) async {
    final box = await _openBox();
    await box.add(zikr);
  }

  /// تعديل زكر حسب الـ index
  static Future<void> updateZikr(int index, ZikrModel updatedZikr) async {
    final box = await _openBox();
    await box.putAt(index, updatedZikr);
  }

  /// حذف زكر
  static Future<void> deleteZikr(int index) async {
    final box = await _openBox();
    await box.deleteAt(index);
  }

  /// جلب كل الأذكار
  static Future<List<ZikrModel>> getAllZikr() async {
    final box = await _openBox();
    return box.values.toList();
  }

  /// حذف الكل
  static Future<void> clearAll() async {
    final box = await _openBox();
    await box.clear();
  }
}
