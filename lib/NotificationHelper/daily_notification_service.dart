import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import 'unified_notification_service.dart';

class DailyMessageNotificationService {
  final List<String> messages;
  final int notificationId;
  final String notificationTitle;
  final String notificationKey;
  final AndroidNotificationSound? sound;

  DailyMessageNotificationService({
    required this.messages,
    required this.notificationId,
    required this.notificationTitle,
    required this.notificationKey,
    this.sound, // ✅ اختياري
  });

  Future<void> init() async {
    await UnifiedNotificationService.init();
  }

  Future<void> scheduleDailyNotificationFromStoredTime() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTime = prefs.getString('${notificationKey}_notification_time');
    if (storedTime == null) {
      print('⚠️ لم يتم تحديد وقت الإشعار بعد! ($notificationKey)');
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
      await plugin.cancel(notificationId);

      final prefs = await SharedPreferences.getInstance();

      final messageIndexKey = 'message_index_$notificationKey';
      int currentIndex = prefs.getInt(messageIndexKey) ?? 0;
      String currentMessage = messages[currentIndex % messages.length];
      await prefs.setInt(messageIndexKey, (currentIndex + 1) % messages.length);

      final time = TimeOfDay(hour: hour, minute: minute);
      final scheduledDate = _nextInstanceOfTime(time);

      print('📅 جدولة إشعار "$notificationKey" في $hour:$minute');
      print('📅 التاريخ المجدول: $scheduledDate');

      // ✅ بناء تفاصيل الإشعار مع شرط على الصوت
      final androidDetails = AndroidNotificationDetails(
        'azkar_channel',
        'أذكار',
        channelDescription: 'إشعارات الأذكار اليومية',
        importance: Importance.high,
        priority: Priority.high,
        sound: sound, // ✅ يمكن أن تكون null
        icon: '@mipmap/launcher_icon',
        playSound: sound != null, // ✅ لا تشغل صوت إذا لم يتم تمرير sound
        enableVibration: true,
        enableLights: false,
        color: Color(0xFF4CAF50),
        colorized: true,
        autoCancel: true,
        ongoing: false,
        showWhen: true,
        category: AndroidNotificationCategory.reminder,
        visibility: NotificationVisibility.public,
      );

      await plugin.zonedSchedule(
        notificationId,
        notificationTitle,
        currentMessage,
        scheduledDate,
        NotificationDetails(android: androidDetails),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: notificationKey,
      );

      await UnifiedNotificationService.showPendingNotifications();

      print('✅ تم جدولة إشعار "$notificationKey" بنجاح 🕒');
    } catch (e) {
      print('❌ خطأ في جدولة إشعار "$notificationKey": $e');
    }
  }

  tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final now = DateTime.now();
    final localLocation = tz.local;
    final nowTZ = tz.TZDateTime.from(now, localLocation);

    tz.TZDateTime scheduled = tz.TZDateTime(
        localLocation, nowTZ.year, nowTZ.month, nowTZ.day, time.hour, time.minute);

    if (scheduled.isBefore(nowTZ)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  Future<void> testNotification() async {
    await UnifiedNotificationService.showTestNotification();
  }

  Future<void> cancelAllNotifications() async {
    await UnifiedNotificationService.cancelAllNotifications();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await UnifiedNotificationService.plugin.pendingNotificationRequests();
  }
}
