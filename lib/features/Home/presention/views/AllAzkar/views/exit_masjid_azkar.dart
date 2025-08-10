import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/exit_masjid_list.dart';

class ExitMasjidAzkar extends StatelessWidget {
  const ExitMasjidAzkar({super.key});
  static const String routeName = Routes.MosqueOutAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: exitMasjidAzkar , title: 'خروج من المسجد',
        specialCounts: {
        4: 3,
        3: 9,
        5: 7,
        6: 2,

      },) ,
    );
  }
}
