
import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../date/tasbeeh_list.dart';
import '../widget/masbaha_body.dart';


class TasbeehView extends StatelessWidget {
  const TasbeehView({super.key});
  static const String routeName = Routes.tasbeehView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body: MasbahaBody(title:  "تسبيح",
  list: tasbeehList,
),
    );
  }
}
