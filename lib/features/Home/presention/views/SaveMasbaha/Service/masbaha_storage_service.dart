import 'package:hive_flutter/hive_flutter.dart';
import '../model/masbaha_model.dart';

class MasbahaStorageService {
  static const String _boxName = 'MasbahaBox';

  Future<void> saveMasbaha({
    required String title,
    required int count,
    required Duration duration,
  }) async {
    final box = Hive.box<MasbahaModel>(_boxName);

    final tasbeeh = MasbahaModel(
      title: title,
      count: count,
      duration: duration,
      date: DateTime.now(),
    );

    await box.add(tasbeeh);
  }


  List<MasbahaModel> getAllItems() {
    final box = Hive.box<MasbahaModel>(_boxName);
    return box.values.toList();
  }

  Future<void> deleteItem(int index) async {
    final box = Hive.box<MasbahaModel>(_boxName);
    await box.deleteAt(index);
  }

  Future<void> clearAll() async {
    final box = Hive.box<MasbahaModel>(_boxName);
    await box.clear();
  }

  void printSavedMasbahaItems() async {
    // تأكد إن الصندوق مفتوح
    final box = await Hive.openBox<MasbahaModel>('masbahaBox');

    if (box.isEmpty) {
      print('⚠️ لا يوجد عناصر محفوظة في المسبحة.');
      return;
    }

    print('✅ محتوى صندوق المسبحة:');
    for (int i = 0; i < box.length; i++) {
      final item = box.getAt(i);
      print('--------------------------');
      print('📿 العنوان: ${item?.title}');
      print('🔢 العدد: ${item?.count}');
      print('⏱️ المدة: ${item?.duration.inSeconds} ثانية');
      print('📅 التاريخ: ${item?.date}');
    }
  }
}
