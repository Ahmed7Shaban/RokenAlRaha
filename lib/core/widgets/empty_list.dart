import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../source/app_lottie.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
      AppLottie.EmptyList,
        width: 220,
        height: 220,
        fit: BoxFit.contain,
      ),
    );
  }
}
