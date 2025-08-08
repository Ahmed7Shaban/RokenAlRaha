import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveNotificationTime(TimeOfDay time) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('notification_hour', time.hour);
  await prefs.setInt('notification_minute', time.minute);
}
