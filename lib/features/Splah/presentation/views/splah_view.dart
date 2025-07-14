import 'package:flutter/material.dart';

import '../../../../routes/routes.dart';
import '../widgets/body_splash.dart';

class SplahView extends StatelessWidget {
  const SplahView({super.key});
  static const String routeName = Routes.splash;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodySplash());
  }
}
