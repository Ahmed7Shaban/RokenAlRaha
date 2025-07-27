
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/travel_list.dart';

class TravelAzkar extends StatelessWidget {
  const TravelAzkar({super.key});
  static const String routeName = Routes.TravelAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: travelDuaList , title: 'السفر') ,
    );
  }
}
