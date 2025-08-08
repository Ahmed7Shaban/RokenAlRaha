import 'package:hive/hive.dart';

part 'prayer_notification_model.g.dart';

@HiveType(typeId: 5)
class PrayerNotificationModel extends HiveObject {
  @HiveField(0)
  bool fajr;

  @HiveField(1)
  bool sunrise;

  @HiveField(2)
  bool dhuhr;

  @HiveField(3)
  bool asr;

  @HiveField(4)
  bool maghrib;

  @HiveField(5)
  bool isha;

  PrayerNotificationModel({
    this.fajr = true,
    this.sunrise = true,
    this.dhuhr = true,
    this.asr = true,
    this.maghrib = true,
    this.isha = true,
  });
}
