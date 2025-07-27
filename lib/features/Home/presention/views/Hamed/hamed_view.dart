import 'package:flutter/material.dart';

import '../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../routes/routes.dart';
import 'date/hamed_list.dart';

class HamedView extends StatelessWidget {
  const HamedView({super.key});
  static const String routeName = Routes.hamed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyForAllAzkar(list: hamdList, title: 'الحمد',),
    );
  }
}
