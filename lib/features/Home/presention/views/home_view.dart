import 'package:flutter/material.dart';

import '../../../../routes/routes.dart';
import 'widgets/body_home_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = Routes.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BodyHomeView());
  }
}
