import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/wakeUp_list.dart';

class WakeUpAzkar extends StatelessWidget {
  const WakeUpAzkar({super.key});
  static const String routeName = Routes.WakeUpAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: wakeUpAzkar , title: 'أذكار الاستيقاظ'),
    );
  }
}
