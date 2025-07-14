// lib/features/daily_aya/logic/aya_storage.dart

import 'package:shared_preferences/shared_preferences.dart';

class AyaStorage {
  static const _key = 'startDate';

  /// حفظ تاريخ أول مرة يشتغل فيها التطبيق
  Future<void> saveStartDateIfNotExists() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_key)) {
      await prefs.setString(_key, DateTime.now().toIso8601String());
    }
  }

  /// استرجاع تاريخ البداية
  Future<DateTime> getStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateStr = prefs.getString(_key);
    if (dateStr != null) {
      return DateTime.parse(dateStr);
    } else {
      final now = DateTime.now();
      await prefs.setString(_key, now.toIso8601String());
      return now;
    }
  }
}
