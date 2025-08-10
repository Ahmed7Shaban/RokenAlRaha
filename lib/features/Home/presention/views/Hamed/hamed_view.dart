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
      body: BodyForAllAzkar(list: hamdList, title: 'الحمد',
        specialCounts: {
          4: 3,
          27: 3,
          29: 9,
          32: 9,
          13: 7,
          6: 2,
          23: 2,
          22: 6,
          18: 3,
          15: 2,
          20: 4,
          8: 4,
        },),
    );
  }
}
