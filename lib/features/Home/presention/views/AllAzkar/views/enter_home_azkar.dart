import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/enter_home_list.dart';

class EnterHomeAzkar extends StatelessWidget {
  const EnterHomeAzkar({super.key});
  static const String routeName = Routes.HomeInAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: azkarEnterHome , title: 'دخول المنزل',
        specialCounts: {
        4: 3,
        27: 3,
        29: 9,
        30: 9,
        13: 7,
        6: 2,
        23: 2,
        22: 6,
        18: 3,
        15: 2,
        8: 4,
      },) ,
    );
  }
}
