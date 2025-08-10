import 'package:flutter/material.dart';

import '../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../routes/routes.dart';
import 'date/ruqyah_list.dart';

class RuqyahView extends StatelessWidget {
  const RuqyahView({super.key});
  static const String routeName = Routes.Ruqyah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyForAllAzkar(list: ruqyahList, title: "الرُقية الشرعية ",
        specialCounts: {
        0: 3,
        13: 7,
      },
      ),
    );
  }
}
