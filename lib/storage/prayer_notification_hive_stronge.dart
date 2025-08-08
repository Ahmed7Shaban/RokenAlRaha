import 'package:hive/hive.dart';
import '../constants.dart';
import '../features/Home/presention/views/SettingView/views/Adhan/model/prayer_notification_model.dart';

class PrayerNotificationHiveService {
  static const String _boxName = prayerNotificationBox;

  /// 🔁 تهيئة البوكس وتسجيل الأدابتر
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(PrayerNotificationModelAdapter());
      print('✅ تم تسجيل الأدابتر بنجاح');
    }

    await Hive.openBox<PrayerNotificationModel>(_boxName);
    print('📦 تم فتح البوكس $_boxName');

    final box = Hive.box<PrayerNotificationModel>(_boxName);
    if (!box.containsKey('data')) {
      final defaultSettings = PrayerNotificationModel(
        fajr: true,
        sunrise: true,
        dhuhr: true,
        asr: true,
        maghrib: true,
        isha: true,
      );
      await box.put('data', defaultSettings);
      print('🆕 تم إنشاء إعدادات افتراضية: $defaultSettings');
    } else {
      print('ℹ️ الإعدادات موجودة مسبقاً: ${box.get('data')}');
    }
  }

  /// ✅ جلب الإعدادات الحالية
  static PrayerNotificationModel getSettings() {
    final box = Hive.box<PrayerNotificationModel>(_boxName);
    final settings = box.get('data')!;
    print('🔍 جلب الإعدادات الحالية: $settings');
    return settings;
  }

  /// ✅ تحديث قيمة معينة لصلاة واحدة
  static Future<void> updatePrayer(String prayerKey, bool value) async {
    final box = Hive.box<PrayerNotificationModel>(_boxName);
    final model = box.get('data');

    if (model != null) {
      print('✏️ قبل التحديث: $model');
      switch (prayerKey) {
        case 'fajr':
          model.fajr = value;
          break;
        case 'sunrise':
          model.sunrise = value;
          break;
        case 'dhuhr':
          model.dhuhr = value;
          break;
        case 'asr':
          model.asr = value;
          break;
        case 'maghrib':
          model.maghrib = value;
          break;
        case 'isha':
          model.isha = value;
          break;
        default:
          print('❌ مفتاح غير معروف: $prayerKey');
          return;
      }

      await model.save();
      print('✅ تم تحديث $prayerKey إلى $value');
      print('📥 بعد التحديث: $model');
    } else {
      print('❌ لا يوجد موديل محفوظ للتحديث');
    }
  }

  /// ✅ التحقق هل الصلاة مفعّلة أو لا
  static bool isPrayerEnabled(String prayerKey) {
    final model = getSettings();
    bool result;
    switch (prayerKey) {
      case 'fajr':
        result = model.fajr;
        break;
      case 'sunrise':
        result = model.sunrise;
        break;
      case 'dhuhr':
        result = model.dhuhr;
        break;
      case 'asr':
        result = model.asr;
        break;
      case 'maghrib':
        result = model.maghrib;
        break;
      case 'isha':
        result = model.isha;
        break;
      default:
        print('❌ مفتاح غير معروف: $prayerKey');
        return false;
    }

    print('🔍 حالة $prayerKey: ${result ? "مفعّلة ✅" : "غير مفعّلة ❌"}');
    return result;
  }
}
