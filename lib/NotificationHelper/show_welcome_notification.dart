import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> ShowWelcomeNotification() async {
  const androidSettings = AndroidInitializationSettings(
    'launcher_icon',
  );
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'test_channel_id',
    'Test Notifications',
    channelDescription: 'ترحيب',

    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    icon: '@mipmap/launcher_icon',

  );

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    'مرحبًا بك في ركن الراحة ',
    'نورّت تطبيقنا، ونتمنى لك تجربة روحانية مميزة ومريحة 💫',
    notificationDetails,
  );
}
