import 'package:flutter/material.dart';

import '../../../../../../core/widgets/action_button.dart';
import '../../../../../../source/app_images.dart';

class RowActionIcons extends StatelessWidget {
  const RowActionIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButton(
                imagePath: Assets.liked,
                onTap: () {},
              ),
              const SizedBox(width: 30),
              ActionButton(
                imagePath: Assets.saved,
                onTap: () {},
              )
            ]
        ),
      ),
    );
  }




}
