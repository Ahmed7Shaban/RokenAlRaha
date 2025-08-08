import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../storage/prayer_notification_hive_stronge.dart';
import 'unified_notification_service.dart';

class PrayerNotificationService {
  static Future<void> init() async {
    // استخدام الخدمة الموحدة
    await UnifiedNotificationService.init();
  }

  static Future<void> schedulePrayerNotification({
    required int id,
    required String title,
    required DateTime dateTime,
    required String soundAsset,
  }) async {
    final plugin = UnifiedNotificationService.plugin;
    
    await plugin.zonedSchedule(
      id,
      '🕌 حان موعد $title',
      'حان الآن موعد صلاة $title - بارك الله فيك',
      tz.TZDateTime.from(dateTime, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_notifications_channel',
          'إشعارات الصلاة',
          channelDescription: 'تنبيهات مواقيت الصلاة',
          sound: RawResourceAndroidNotificationSound(soundAsset),
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/launcher_icon',
          playSound: true,
          enableVibration: true,
          enableLights: false, // تعطيل الأضواء لتجنب الخطأ
          color: Color(0xFF2196F3),
          colorized: true,
          autoCancel: true,
          ongoing: false,
          showWhen: true,
          category: AndroidNotificationCategory.reminder,
          visibility: NotificationVisibility.public,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    
    print('✅ تم جدولة إشعار الصلاة: $title في ${dateTime.toString()}');
  }

  static Future<void> updateAllPrayerNotifications(
      Map<String, DateTime> prayerTimes,
      ) async {
    final settings = PrayerNotificationHiveService.getSettings();

    final List<Map<String, dynamic>> prayers = [
      {
        'key': 'fajr',
        'name': 'الفجر',
        'enabled': settings.fajr,
        'time': prayerTimes['fajr'],
        'id': 1,
      },
      {
        'key': 'sunrise',
        'name': 'الشروق',
        'enabled': settings.sunrise,
        'time': prayerTimes['sunrise'],
        'id': 2,
      },
      {
        'key': 'dhuhr',
        'name': 'الظهر',
        'enabled': settings.dhuhr,
        'time': prayerTimes['dhuhr'],
        'id': 3,
      },
      {
        'key': 'asr',
        'name': 'العصر',
        'enabled': settings.asr,
        'time': prayerTimes['asr'],
        'id': 4,
      },
      {
        'key': 'maghrib',
        'name': 'المغرب',
        'enabled': settings.maghrib,
        'time': prayerTimes['maghrib'],
        'id': 5,
      },
      {
        'key': 'isha',
        'name': 'العشاء',
        'enabled': settings.isha,
        'time': prayerTimes['isha'],
        'id': 6,
      },
    ];

    for (var prayer in prayers) {
      if (prayer['enabled'] && prayer['time'] != null) {
        await schedulePrayerNotification(
          id: prayer['id'],
          title: prayer['name'],
          dateTime: prayer['time'],
          soundAsset: 'azan',
        );
      } else {
        await cancelPrayerNotification(prayer['id']);
      }
    }
  }

  static Future<void> cancelPrayerNotification(int id) async {
    final plugin = UnifiedNotificationService.plugin;
    await plugin.cancel(id);
    print('🗑️ تم إلغاء إشعار الصلاة ID: $id');
  }
}
