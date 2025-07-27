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
      body: BodyForAllAzkar(list:duaasList, title: "ادعية الانبياء"),
    );
  }
}
