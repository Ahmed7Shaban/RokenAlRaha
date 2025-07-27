import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../special_azkar_view.dart';

class DuaYunusView extends StatelessWidget {
  const DuaYunusView({super.key});
  static const String routeName = Routes.DuaYunus;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SpecialAzkarView(title: 'دعاء الكرب - يونس عليه السلام', ZkrName: 'لا إله إلا أنت سبحانك إني كنت من الظالمين',),

    );
  }
}
