import 'package:flutter/material.dart';
import '../../../../../routes/routes.dart';
import 'widget/quran_reading_body.dart';

class QuranReadingView extends StatelessWidget {
  const QuranReadingView({super.key});
  static const String routeName = Routes.quranReading;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: QuranReadingBody());
  }
}
