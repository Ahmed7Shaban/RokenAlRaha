
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/exit_home_list.dart';

class ExitHomeAzkar extends StatelessWidget {
  const ExitHomeAzkar({super.key});
  static const String routeName = Routes.HomeOutAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: azkarLeavingHome , title: ' خروج من  المنزل',
        specialCounts: {
        4: 3,
        3: 9,
        5: 7,
        6: 2,

      },
      ) ,
    );
  }
}
