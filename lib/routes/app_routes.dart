import 'package:flutter/material.dart';

import '../features/Home/presention/views/QuranReading/quran_reading_view.dart';
import '../features/Home/presention/views/home_view.dart';
import '../features/Home/presention/views/surah_detail_view.dart';
import '../features/Splah/presentation/views/splah_view.dart';
import '../models/surah_model.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplahView.routeName:
        return MaterialPageRoute(builder: (_) => const SplahView());

      case HomeView.routeName:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case QuranReadingView.routeName:
        return MaterialPageRoute(builder: (_) => const QuranReadingView());

      case SurahDetailView.routeName:
        return MaterialPageRoute(builder: (_) => SurahDetailView());

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
