import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';

class PrayerTimeService {
  static Future<PrayerTimes> getPrayerTimes() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final coordinates = Coordinates(position.latitude, position.longitude);
    final params = CalculationMethod.egyptian.getParameters();
    final date = DateComponents.from(DateTime.now());

    return PrayerTimes(coordinates, date, params);
  }
}
