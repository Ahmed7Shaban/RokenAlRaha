import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/sleep_list.dart';

class SleepAzkar extends StatelessWidget {
  const SleepAzkar({super.key});
  static const String routeName = Routes.SleepAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: sleepAzkar, title: ' أذكار النوم '),
    );
  }
}
