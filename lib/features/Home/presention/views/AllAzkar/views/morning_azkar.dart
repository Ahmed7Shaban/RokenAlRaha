import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/morning_list.dart';

class MorningAzkar extends StatelessWidget {
  const MorningAzkar({super.key});
  static const String routeName = Routes.MorningAzkar;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: morningAzkar, title: 'أذكار الصباح',   specialCounts: {
        4: 3,
        3: 9,
        5: 7,
        6: 2,
        10: 2,
        15: 2,

      },),
    );
  }
}
