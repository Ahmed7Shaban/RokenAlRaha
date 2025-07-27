import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/evening_list.dart';

class EveningAzkar extends StatelessWidget {
  const EveningAzkar({super.key});
  static const String routeName = Routes.EveningAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: eveningAzkar , title: 'أذكار المساء '),
    );
  }
}
