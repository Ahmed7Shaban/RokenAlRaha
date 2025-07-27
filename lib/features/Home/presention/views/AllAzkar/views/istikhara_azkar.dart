import 'package:flutter/material.dart';

import '../../../../../../core/widgets/body_for_all_azkar.dart';
import '../../../../../../routes/routes.dart';
import '../date/istikhara_duaa_list.dart';

class IstikharaAzkar extends StatelessWidget {
  const IstikharaAzkar({super.key});
  static const String routeName = Routes.IstikharaAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BodyForAllAzkar(list: istikharaDuaaList , title: ' دعاء الاستخارة') ,
    );
  }
}
