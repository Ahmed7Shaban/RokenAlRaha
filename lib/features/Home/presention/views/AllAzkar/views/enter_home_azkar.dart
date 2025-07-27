import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/enter_home_list.dart';

class EnterHomeAzkar extends StatelessWidget {
  const EnterHomeAzkar({super.key});
  static const String routeName = Routes.HomeInAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: azkarEnterHome , title: 'دخول المنزل') ,
    );
  }
}
