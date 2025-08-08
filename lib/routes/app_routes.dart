import 'package:flutter/material.dart';

import '../features/Home/presention/views/AllAzkar/all_Azkar_view.dart';
import '../features/Home/presention/views/AllAzkar/views/MyAzkar/azkary_view.dart';
import '../features/Home/presention/views/AllAzkar/views/enter_home_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/enter_masjid_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/enter_toilet_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/evening_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/exit_home_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/exit_masjid_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/exit_toilet_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/istikhara_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/morning_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/rain_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/ride_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/sleep_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/travel_azkar.dart';
import '../features/Home/presention/views/AllAzkar/views/wake_up_azkar.dart';
import '../features/Home/presention/views/AppsLink/apps_link.dart';
import '../features/Home/presention/views/AsmaaAllah/asmaa_allah_view.dart';
import '../features/Home/presention/views/AyahAudio/ayah_audio_view.dart';
import '../features/Home/presention/views/Duaas/duaas_view.dart';
import '../features/Home/presention/views/DuaasQuran/duaas_Quran_view.dart';
import '../features/Home/presention/views/Hamed/hamed_view.dart';
import '../features/Home/presention/views/Masbaha/ IstighfarView/istighfar_view.dart';
import '../features/Home/presention/views/Masbaha/TasbeehView/tasbeeh_view.dart';
import '../features/Home/presention/views/PrayerTimes/prayer_times_view.dart';
import '../features/Home/presention/views/Qiblah/qiblah_view.dart';
import '../features/Home/presention/views/QuranReading/quran_reading_view.dart';
import '../features/Home/presention/views/Ruqyah/ruqyah_view.dart';
import '../features/Home/presention/views/SaveMasbaha/save_masbaha_view.dart';
import '../features/Home/presention/views/SettingView/setting_view.dart';
import '../features/Home/presention/views/SettingView/views/Adhan/adhan_view.dart';
import '../features/Home/presention/views/SettingView/views/AzkarNot/DhikrMohammed/dhikr_mohammed.dart';
import '../features/Home/presention/views/SettingView/views/AzkarNot/azkar_not_view.dart';
import '../features/Home/presention/views/SettingView/views/AzkarNot/evening/evening_not_view.dart';
import '../features/Home/presention/views/SettingView/views/AzkarNot/morning/morning_view.dart';
import '../features/Home/presention/views/SpecialAzkar/DuaYunus/dua_yunus_view.dart';
import '../features/Home/presention/views/SpecialAzkar/Hawqalah/hawqalah_view.dart';
import '../features/Home/presention/views/SpecialAzkar/SalatAlaNabi/salat_alnabi_view.dart';
import '../features/Home/presention/views/SurahAudio/surah_audio_view.dart';
import '../features/Home/presention/views/ayah_liked/ayah_liked.dart';
import '../features/Home/presention/views/home_view.dart';
import '../features/Splah/presentation/views/splah_view.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplahView.routeName:
        return MaterialPageRoute(builder: (_) => const SplahView());

      case HomeView.routeName:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case QuranReadingView.routeName:
        return MaterialPageRoute(builder: (_) => const QuranReadingView());
      case AyahAudioView.routeName:
        return MaterialPageRoute(builder: (_) => const AyahAudioView());

      case SurahAudioView.routeName:
        return MaterialPageRoute(builder: (_) => const SurahAudioView());
      case AyahLiked.routeName:
        return MaterialPageRoute(builder: (_) => const AyahLiked());

        case SettingView.routeName:
        return MaterialPageRoute(builder: (_) => const SettingView());

      case TasbeehView.routeName:
        return MaterialPageRoute(builder: (_) => const TasbeehView());

      case IstighfarView.routeName:
        return MaterialPageRoute(builder: (_) => const IstighfarView());

      case SaveMasbahaView.routeName:
        return MaterialPageRoute(builder: (_) => const SaveMasbahaView());

      case AsmaaAllahView.routeName:
        return MaterialPageRoute(builder: (_) => const AsmaaAllahView());

      case HamedView.routeName:
        return MaterialPageRoute(builder: (_) => const HamedView());

      case DuaasView.routeName:
        return MaterialPageRoute(builder: (_) => const DuaasView());

      case DuaasQuranView.routeName:
        return MaterialPageRoute(builder: (_) => const DuaasQuranView());

      case HawqalahView.routeName:
        return MaterialPageRoute(builder: (_) => const HawqalahView());

      case DuaYunusView.routeName:
        return MaterialPageRoute(builder: (_) => const DuaYunusView());

      case SalatAlnabiView.routeName:
        return MaterialPageRoute(builder: (_) => const SalatAlnabiView());

      case RuqyahView.routeName:
        return MaterialPageRoute(builder: (_) => const RuqyahView());

      case AllAzkarView.routeName:
        return MaterialPageRoute(builder: (_) => const AllAzkarView());
      case QiblahView.routeName:
        return MaterialPageRoute(builder: (_) => const QiblahView());
      case AppsLink.routeName:
        return MaterialPageRoute(builder: (_) => const AppsLink());
  case PrayerTimesView.routeName:
        return MaterialPageRoute(builder: (_) => const PrayerTimesView());

      ////// Zekr  Views ///////////////

      case MorningAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const MorningAzkar());

      case EveningAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const EveningAzkar());

      case SleepAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const SleepAzkar());

      case WakeUpAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const WakeUpAzkar());

      // 🕌 دعاء دخول المسجد
      case EnterMasjidAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const EnterMasjidAzkar());

      // 🕌 دعاء الخروج من المسجد
      case ExitMasjidAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const ExitMasjidAzkar());

      // 🏠 دعاء دخول المنزل
      case EnterHomeAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const EnterHomeAzkar());

      // 🏠 دعاء الخروج من المنزل
      case ExitHomeAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const ExitHomeAzkar());

      // 🚽 دعاء دخول الخلاء
      case EnterToiletAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const EnterToiletAzkar());

      // 🚿 دعاء الخروج من الخلاء
      case ExitToiletAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const ExitToiletAzkar());

      // ✈️ دعاء السفر
      case TravelAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const TravelAzkar());

      case RideAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const RideAzkar());

      // 🌧 دعاء نزول المطر
      case RainAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const RainAzkar());

      // 🙏 دعاء الاستخارة
      case IstikharaAzkar.routeName:
        return MaterialPageRoute(builder: (_) => const IstikharaAzkar());

      case AzkaryView.routeName:
        return MaterialPageRoute(builder: (_) => const AzkaryView());



      case AdhanView.routeName:
        return MaterialPageRoute(builder: (_) => const AdhanView());

      case AzkarNotView.routeName:
        return MaterialPageRoute(builder: (_) => const AzkarNotView());

      case MorningNotView.routeName:
        return MaterialPageRoute(builder: (_) => const MorningNotView());

      case EveningNotView.routeName:
        return MaterialPageRoute(builder: (_) => const EveningNotView());

      case DhikrMohammed.routeName:
        return MaterialPageRoute(builder: (_) => const DhikrMohammed());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("404")),
        body: const Center(child: Text("Page not found")),
      ),
    );
  }
}
