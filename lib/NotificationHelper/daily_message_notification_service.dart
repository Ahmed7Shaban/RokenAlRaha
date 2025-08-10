import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../features/Home/presention/views/AllAzkar/date/evening_list.dart';
import '../features/Home/presention/views/AllAzkar/date/morning_list.dart';
import '../features/Home/presention/views/DuaasQuran/date/duaas_quran_list.dart';
import '../features/Home/presention/views/AllAzkar/date/dhikr_mohammed_list.dart';
import 'unified_notification_service.dart';

class DailyMessageNotificationService {
  static const String _morningIndexKey = 'morning_index';
  static const String _eveningIndexKey = 'evening_index';
  static const String _salawatIndexKey = 'salawat_index';
  static const String _quranicDuasIndexKey = 'quranicDuas_index';


  /// 🔧 تهيئة الإشعارات
  static Future<void> init() async {
    if (!UnifiedNotificationService.isInitialized) {
      await UnifiedNotificationService.init();
    }
    await _scheduleDailyMorningAndEvening();
  }

  /// ⏰ جدولة إشعارين يوميًا
  static Future<void> _scheduleDailyMorningAndEvening() async {
    final now = DateTime.now();

    // 🕣 صباحًا
    final morningTime = DateTime(now.year, now.month, now.day, 8);
    await scheduleNotification(
      id: 10,
      title:'🌸 أذكار الصباح - ركن الراحة',
      body: await _getNextZikr(morningAzkar, _morningIndexKey),
      dateTime: morningTime.isBefore(now)
          ? morningTime.add(const Duration(days: 1))
          : morningTime,
      repeat: DateTimeComponents.time,
    );

    // 🌙 مساءً
    final eveningTime = DateTime(now.year, now.month, now.day, 19);
    await scheduleNotification(
      id: 11,
      title: '🌙 أذكار المساء - ركن الراحة',
      body: await _getNextZikr(eveningAzkar, _eveningIndexKey),
      dateTime: eveningTime.isBefore(now)
          ? eveningTime.add(const Duration(days: 1))
          : eveningTime,
      repeat: DateTimeComponents.time,
    );

    final DhikrMohammedTime = DateTime(now.year, now.month, now.day, 17);
    await scheduleNotification(
      id: 12,
      title: '🌿 الصلاة على النبي - ركن الراحة',
      body: await _getNextZikr(salawatMessages, _salawatIndexKey),
      dateTime: DhikrMohammedTime.isBefore(now)
          ? DhikrMohammedTime.add(const Duration(days: 1))
          : DhikrMohammedTime,
      repeat: DateTimeComponents.time,
    );
    final DuaTime = DateTime(now.year, now.month, now.day, 15);
    await scheduleNotification(
      id: 13,
      title: '🌿 دعاء - ركن الراحة',
      body: await _getNextZikr(quranicDuas, _quranicDuasIndexKey),
      dateTime: DuaTime.isBefore(now)
          ? DuaTime.add(const Duration(days: 1))
          : DuaTime,
      repeat: DateTimeComponents.time,
    );
  }

  /// 📌 جلب الذكر التالي وتحديث الـ index
  static Future<String> _getNextZikr(List<String> list, String key) async {
    final prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt(key) ?? 0;

    String zikr = list[index];

    // تحديث المؤشر لليوم التالي
    index = (index + 1) % list.length;
    await prefs.setInt(key, index);

    return zikr;
  }

  /// 🔁 جدولة إشعار مخصص
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    DateTimeComponents? repeat,
    String? payload,
  }) async {
    await UnifiedNotificationService.plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'scheduled_channel',
          'Scheduled Notifications',
          channelDescription: 'Notifications that appear at a set time',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: repeat,
      payload: payload ?? 'custom_payload',
    );
  }

  /// ❌ إلغاء إشعار
  static Future<void> cancelNotification(int id) async {
    await UnifiedNotificationService.plugin.cancel(id);
  }

  /// ❌ إلغاء كل الإشعارات
  static Future<void> cancelAll() async {
    await UnifiedNotificationService.plugin.cancelAll();
  }

  /// 📅 عرض الإشعارات المجدولة
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await UnifiedNotificationService.plugin.pendingNotificationRequests();
  }
}
