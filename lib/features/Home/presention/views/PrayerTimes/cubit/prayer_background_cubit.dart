import 'package:bloc/bloc.dart';

import '../../../../../../source/app_images.dart';


class PrayerBackgroundCubit extends Cubit<String> {
  PrayerBackgroundCubit() : super(_getInitialBackground()) {
    updateBackground();
  }

  static String _getInitialBackground() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return Assets.morning;
    } else if (hour >= 12 && hour < 15) {
      return Assets.night;
    } else if (hour >= 15 && hour < 18) {
      return Assets.afternoon;
    } else if (hour >= 18 && hour < 20) {

      return Assets.sunset;
    } else {
      return Assets.night;
    }
  }

  void updateBackground() {
    emit(_getInitialBackground());
  }
}
