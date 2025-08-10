import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/toilet_entry_dua.dart';

class EnterToiletAzkar extends StatelessWidget {
  const EnterToiletAzkar({super.key});
  static const String routeName = Routes.ToiletInAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: toiletEntryDuas , title: 'دخول الخلاء',
        specialCounts: {
          4: 3,
          3: 9,
          5: 7,
          6: 2,
          8: 4,
        },) ,
    );
  }
}
