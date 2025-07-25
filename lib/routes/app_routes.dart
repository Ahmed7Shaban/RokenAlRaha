import 'package:flutter/material.dart';

import '../features/Home/presention/views/AyahAudio/ayah_audio_view.dart';
import '../features/Home/presention/views/QuranReading/quran_reading_view.dart';
import '../features/Home/presention/views/SurahAudio/surah_audio_view.dart';
import '../features/Home/presention/views/home_view.dart';
import '../features/Home/presention/views/QuranReading/widget/surah_detail_view.dart';
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

    // case SurahDetailView.routeName:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => SurahDetailView(
      //       surahNumber: args['number'],
      //       surahName: args['name'],
      //       ayahCount: args['ayahCount'],
      //     ),
      //   );
      // case CheckoutView.routeName:
      //   final cart = settings.arguments as CartEntity;
      //   return MaterialPageRoute(
      //     builder: (_) => CheckoutView(cartEntity: cart),
      //   );

      // case BestSellingView.routeName:
      //   return MaterialPageRoute(builder: (_) => const BestSellingView());

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
