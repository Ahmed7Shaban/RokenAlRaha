import 'package:flutter/material.dart';

import '../../../../../routes/routes.dart';
import 'widget/ayah_liked_body.dart';

class AyahLiked extends StatelessWidget {
  const AyahLiked({super.key});
  static const String routeName = Routes.AyahLiked;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
body: AyahLikedBody(),
    );
  }
}
