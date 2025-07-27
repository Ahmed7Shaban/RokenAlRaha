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
      body: BodyForAllAzkar(list:quranicDuas, title: "ادعية قرانية"),
    );
  }
}
