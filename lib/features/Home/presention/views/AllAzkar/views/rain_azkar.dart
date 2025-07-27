
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/rain_dua_list.dart';

class RainAzkar extends StatelessWidget {
  const RainAzkar({super.key});
  static const String routeName = Routes.RainAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: rainDuaList , title: 'دعاء المطر') ,
    );
  }
}
