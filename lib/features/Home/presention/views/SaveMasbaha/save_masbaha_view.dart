import 'package:flutter/material.dart';

import '../../../../../routes/routes.dart';
import 'widget/save_masbaha_body.dart';

class SaveMasbahaView extends StatelessWidget {
  const SaveMasbahaView({super.key});
  static const String routeName = Routes.SaveMasbaha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SaveMasbahaBody(),
    );
  }
}
