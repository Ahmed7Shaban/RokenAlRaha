import 'package:flutter/material.dart';

import '../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../routes/routes.dart';
import 'date/duaas_list.dart';


class DuaasView extends StatelessWidget {
  const DuaasView({super.key});
  static const String routeName = Routes.Duaas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyForAllAzkar(list:duaasList, title: "ادعية الانبياء",
      specialCounts: {
      4: 3,
      27: 3,
      29: 9,
      33: 9,
      13: 7,
      6: 2,
      23: 2,
      22: 6,
      18: 3,
      15: 2,
      20: 4,
      8: 4,
      },),
    );
  }
}
