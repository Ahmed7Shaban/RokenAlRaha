import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/evening_list.dart';

class EveningAzkar extends StatelessWidget {
  const EveningAzkar({super.key});
  static const String routeName = Routes.EveningAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: eveningAzkar , title: 'أذكار المساء ',
        specialCounts: {
        4: 3,
        3: 9,
        5: 7,
        6: 2,
        8: 4,
        10: 4,
        12: 6,
        17: 3,
        19: 6,
      },
      ),
    );
  }
}
