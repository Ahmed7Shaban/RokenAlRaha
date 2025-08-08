import 'package:flutter/material.dart';

import '../../../../../../../routes/routes.dart';
import 'widget/azkar_not_body.dart';

class AzkarNotView extends StatelessWidget {
  const AzkarNotView({super.key});
  static const String routeName = Routes.AzkarNot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AzkarNotBody(),
    );
  }
}
