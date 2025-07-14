import 'package:flutter/material.dart';

import 'bockground_splash_view.dart';
import 'bottom_section.dart';

class BodySplash extends StatelessWidget {
  const BodySplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [BockgroundSplashView(), BottomSection()]);
  }
}
