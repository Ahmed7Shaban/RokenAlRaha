import 'package:hive/hive.dart';
import '../constants.dart';
import '../features/Home/presention/views/AllAzkar/views/MyAzkar/model/zikr_model.dart';

class ZikrService {
  static const String _boxName = azkar;

  /// افتح البوكس
  static Future<Box<ZikrModel>> _openBox() async {
    print('[ZikrService] فتح البوكس $_boxName');
    return await Hive.openBox<ZikrModel>(_boxName);
  }

  /// أضف زكر جديد
  static Future<void> addZikr(ZikrModel zikr) async {
    print('[ZikrService] إضافة ذكر جديد: ${zikr.title}');
    final box = await _openBox();
    await box.add(zikr);
    print('[ZikrService] تم إضافة الذكر. عدد العناصر الآن: ${box.length}');
  }

  /// تعديل زكر حسب الـ index
  static Future<void> updateZikr(int index, ZikrModel updatedZikr) async {
    print('[ZikrService] تعديل الذكر عند index $index بالعنوان: ${updatedZikr.title}');
    final box = await _openBox();
    await box.putAt(index, updatedZikr);
    print('[ZikrService] تم تعديل الذكر.');
  }

  /// حذف زكر
  static Future<void> deleteZikr(int index) async {
    print('[ZikrService] حذف الذكر عند index $index');
    final box = await _openBox();
    await box.deleteAt(index);
    print('[ZikrService] تم الحذف. عدد العناصر الآن: ${box.length}');
  }

  /// جلب كل الأذكار
  static Future<List<ZikrModel>> getAllZikr() async {
    print('[ZikrService] جاري جلب كل الأذكار...');
    final box = await _openBox();
    final items = box.values.toList();
    print('[ZikrService] تم جلب ${items.length} ذكر.');
    return items;
  }

  /// حذف الكل
  static Future<void> clearAll() async {
    print('[ZikrService] حذف جميع الأذكار...');
    final box = await _openBox();
    await box.clear();
    print('[ZikrService] تم حذف جميع الأذكار.');
  }
}
