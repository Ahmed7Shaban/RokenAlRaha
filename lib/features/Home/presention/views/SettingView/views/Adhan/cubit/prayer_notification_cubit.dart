import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../storage/prayer_notification_hive_stronge.dart';
import '../model/prayer_notification_model.dart';

class PrayerNotificationCubit extends Cubit<PrayerNotificationModel> {
  PrayerNotificationCubit()
      : super(PrayerNotificationHiveService.getSettings()) {
    print('📦 Cubit بدأ بالحالة: ${PrayerNotificationHiveService.getSettings()}');
  }

  /// ✅ تحميل الإعدادات الحالية من Hive وتحديث الحالة داخل Cubit
  void loadNotifications() {
    final currentSettings = PrayerNotificationHiveService.getSettings();
    print('🔄 loadNotifications -> الحالة المُحمّلة: $currentSettings');
    emit(currentSettings);
  }

  /// ✅ تبديل حالة صلاة معينة (تفعيل/تعطيل)
  void togglePrayer(String prayerKey, bool value) async {
    print('✏️ togglePrayer -> $prayerKey إلى ${value ? "مفعّلة ✅" : "غير مفعّلة ❌"}');

    await PrayerNotificationHiveService.updatePrayer(prayerKey, value);

    final updated = PrayerNotificationHiveService.getSettings();
    print('📥 الحالة الجديدة بعد التحديث: $updated');

    emit(updated);
  }

  /// ✅ التحقق هل الصلاة مفعّلة أو لا
  bool isEnabled(String prayerKey) {
    final enabled = PrayerNotificationHiveService.isPrayerEnabled(prayerKey);
    print('🔍 isEnabled($prayerKey) = ${enabled ? "✅ مفعّلة" : "❌ غير مفعّلة"}');
    return enabled;
  }
}
