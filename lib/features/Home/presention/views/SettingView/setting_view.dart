import 'package:flutter/material.dart';

import '../../../../../routes/routes.dart';
import 'widget/setting_body.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});
  static const String routeName = Routes.setting;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingBody(),
    );
  }
}
