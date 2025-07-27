import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoader extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;

  const LottieLoader({
    Key? key,
    this.width = 200,
    this.height = 200,
    this.assetPath = 'assets/lottie/loading.json',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(assetPath ,
      width: width ,height: height  )
    );
  }
}
