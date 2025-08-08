import 'package:flutter/material.dart';

import '../../../../../../../routes/routes.dart';
import 'widget/adhan_body.dart';

class AdhanView extends StatelessWidget {
  const AdhanView({super.key});
  static const String routeName = Routes.prayerNot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdhanBody(),
    );
  }
}
