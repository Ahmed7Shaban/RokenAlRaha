import 'package:flutter/material.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

class NavButton extends StatelessWidget {
  const NavButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // انتقل إلى الشاشة التالية
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: AppColors.goldenYellow,
          size: 30,
        ),
      ),
    );
  }
}
