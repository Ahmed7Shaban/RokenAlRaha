import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> requestExactAlarmPermission() async {
  if (Platform.isAndroid) {
    const MethodChannel platform = MethodChannel('exact_alarm_permission');
    try {
      final bool granted = await platform.invokeMethod('requestExactAlarm');
      debugPrint('Exact alarm permission granted: $granted');
    } on PlatformException catch (e) {
      debugPrint("Failed to request exact alarm permission: ${e.message}");
    }
  }
}
