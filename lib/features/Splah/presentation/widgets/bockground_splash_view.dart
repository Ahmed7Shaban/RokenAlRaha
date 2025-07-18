import 'package:flutter/material.dart';
import 'package:roken_raha/features/Splah/presentation/widgets/app_title.dart';

import '../../../../source/app_images.dart';

class BockgroundSplashView extends StatelessWidget {
  const BockgroundSplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesBackgroundSplash),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 110),
            child: AppTitle(),
          ),
        ),
      ],
    );
  }
}
