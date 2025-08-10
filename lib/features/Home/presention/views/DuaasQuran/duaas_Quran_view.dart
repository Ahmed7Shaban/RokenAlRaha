import 'package:flutter/material.dart';

import '../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../routes/routes.dart';
import 'date/duaas_quran_list.dart';

class DuaasQuranView extends StatelessWidget {
  const DuaasQuranView({super.key});
  static const String routeName = Routes.DuaasQ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyForAllAzkar(list:quranicDuas, title: "ادعية قرانية", specialCounts: {
        4: 3,
        27: 3,
        29: 9,
        32: 9,
        13: 7,
        6: 2,
        23: 2,
        22: 6,
        18: 3,
        15: 2,
        20: 4,
        30: 16,
        8: 4,
      },),
    );
  }
}
