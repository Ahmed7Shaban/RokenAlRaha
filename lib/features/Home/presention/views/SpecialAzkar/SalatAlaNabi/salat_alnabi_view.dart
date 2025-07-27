import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../special_azkar_view.dart';

class SalatAlnabiView extends StatelessWidget {
  const SalatAlnabiView({super.key});
  static const String routeName = Routes.SalatAlnabi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpecialAzkarView(title: 'الصلاة على النبي ﷺ', ZkrName: 'اللهم صلِّ وسلم وبارك على سيدنا محمد',),
    );
  }
}
