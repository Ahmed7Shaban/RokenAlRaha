import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'unified_notification_service.dart';

class DailyMessageNotificationService {
  final List<String> messages;

  DailyMessageNotificationService({required this.messages});

  Future<void> init() async {
    // استخدام الخدمة الموحدة
    await UnifiedNotificationService.init();
  }

  Future<void> scheduleDailyNotificationFromStoredTime() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTime = prefs.getString('daily_notification_time');
    if (storedTime == null) {
      print('⚠️ لم يتم تحديد وقت الإشعار بعد!');
      return;
    }

    final parts = storedTime.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    await scheduleDailyNotification(hour: hour, minute: minute);
  }

  Future<void> scheduleDailyNotification({required int hour, required int minute}) async {
    try {
      final plugin = UnifiedNotificationService.plugin;

      // إلغاء الإشعارات السابقة
      await plugin.cancel(7);

      final prefs = await SharedPreferences.getInstance();

      int currentIndex = prefs.getInt('message_index') ?? 0;
      String currentMessage = messages[currentIndex % messages.length];
      int nextIndex = (currentIndex + 1) % messages.length;
      await prefs.setInt('message_index', nextIndex);

      final time = TimeOfDay(hour: hour, minute: minute);
      final scheduledDate = _nextInstanceOfTime(time);

      print('📅 محاولة جدولة إشعار في $hour:$minute');
      print('📅 التاريخ المجدول: $scheduledDate');

      await plugin.zonedSchedule(
        7,
        '🌸 أذكار الصباح - ركن الراحة',
        currentMessage,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'morning_azkar_channel',
            'أذكار الصباح',
            channelDescription: 'إشعارات أذكار الصباح اليومية',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/launcher_icon',
            playSound: true,
            enableVibration: true,
            enableLights: false, // تعطيل الأضواء لتجنب الخطأ
            color: Color(0xFF4CAF50),
            colorized: true,
            autoCancel: true,
            ongoing: false,
            showWhen: true,
            usesChronometer: false,
            fullScreenIntent: false,
            category: AndroidNotificationCategory.reminder,
            visibility: NotificationVisibility.public,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'morning_azkar',
      );

      // التحقق من الإشعارات المجدولة
      await UnifiedNotificationService.showPendingNotifications();

      print('✅ تم جدولة إشعار أذكار الصباح بنجاح عند $hour:$minute');
    } catch (e) {
      print('❌ خطأ في جدولة الإشعار: $e');
    }
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    // إنشاء التوقيت المحلي بدلاً من UTC
    final now = DateTime.now();
    final localLocation = tz.getLocation('Africa/Cairo'); // أو استخدم tz.local
    final nowTZ = tz.TZDateTime.from(now, localLocation);

    tz.TZDateTime scheduled = tz.TZDateTime(
        localLocation, nowTZ.year, nowTZ.month, nowTZ.day, time.hour, time.minute);

    print('🕐 الوقت الحالي (محلي): ${nowTZ.toString()}');
    print('🕐 الوقت المجدول (أولي): ${scheduled.toString()}');

    // إذا كان الوقت المجدول قد مضى اليوم، اجدوله للغد
    if (scheduled.isBefore(nowTZ)) {
      scheduled = scheduled.add(const Duration(days: 1));
      print('⏭️ تم نقل الإشعار للغد: ${scheduled.toString()}');
    } else {
      print('✅ الإشعار مجدول لليوم: ${scheduled.toString()}');
    }

    // التحقق من المنطقة الزمنية
    print('🌍 المنطقة الزمنية: ${scheduled.location.name}');
    print('🌍 فرق التوقيت: UTC${scheduled.timeZoneOffset.inHours >= 0 ? '+' : ''}${scheduled.timeZoneOffset.inHours}');

    return scheduled;
  }

  // دالة لاختبار الإشعارات (إشعار فوري)
  Future<void> testNotification() async {
    await UnifiedNotificationService.showTestNotification();
  }

  // دالة لإلغاء جميع الإشعارات
  Future<void> cancelAllNotifications() async {
    await UnifiedNotificationService.cancelAllNotifications();
  }

  // دالة للحصول على قائمة الإشعارات المجدولة
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await UnifiedNotificationService.plugin.pendingNotificationRequests();
  }
}
