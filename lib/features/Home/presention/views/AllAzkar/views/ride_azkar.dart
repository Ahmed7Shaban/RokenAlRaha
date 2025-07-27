
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/ride_dua_list.dart';

class RideAzkar extends StatelessWidget {
  const RideAzkar({super.key});
  static const String routeName = Routes.TransportAzkar;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: rideDuaList, title: 'دعاء الركوب'),
    );
  }
}
