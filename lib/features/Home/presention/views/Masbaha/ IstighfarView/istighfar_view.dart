import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../TasbeehView/date/istighfar_list.dart';
import '../widget/masbaha_body.dart';

class IstighfarView extends StatelessWidget {
  const IstighfarView({super.key});
  static const String routeName = Routes.istighfarView;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: MasbahaBody(title: 'أستغفار', list: istighfarList,),
    );}
}
