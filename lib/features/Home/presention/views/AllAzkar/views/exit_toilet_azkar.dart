import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/toilet_exit_dua.dart';

class ExitToiletAzkar extends StatelessWidget {
  const ExitToiletAzkar({super.key});
  static const String routeName = Routes.ToiletOutAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: toiletExitDuas , title: 'خروج من الخلاء' ,
        specialCounts: {
      4: 3,
      3: 9,
      5: 7,
      6: 2,

      },) ,
    );
  }
}
