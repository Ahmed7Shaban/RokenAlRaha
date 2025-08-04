import 'package:flutter/material.dart';

import '../../source/app_images.dart';
import '../theme/app_colors.dart';
import 'action_button.dart';
import 'title_appbar.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    super.key,
    required this.title,
    this.showActions = false,
    this.onTapSaved,
  });

  final String title;
  final bool showActions;
  final VoidCallback? onTapSaved;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),

          Center(child: TitleAppbar(title: title)),
          const SizedBox(height: 20),
          if (showActions)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ActionButton(
                  imagePath: Assets.saved,
                  onTap: onTapSaved ?? () {},
                ),
              ],
            ),
          const SizedBox(height: 20),

        ],
      ),
    );
  }
}
