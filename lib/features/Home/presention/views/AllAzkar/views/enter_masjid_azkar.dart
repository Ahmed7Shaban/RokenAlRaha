import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/enter_masjid_list.dart';

class EnterMasjidAzkar extends StatelessWidget {
  const EnterMasjidAzkar({super.key});
  static const String routeName = Routes.MosqueInAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: enterMasjidAzkar , title: 'دخول المسجد',
        specialCounts: {
        4: 3,
        27: 3,
        12: 9,
        16: 9,
        13: 7,
        6: 2,
        17: 2,
        20: 6,
        18: 3,
        15: 2,
        8: 4,
      },) ,
    );
  }
}
