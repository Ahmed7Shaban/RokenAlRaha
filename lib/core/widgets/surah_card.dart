import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/surah_model.dart';
import '../../source/app_images.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SurahCard extends StatelessWidget {
  final SurahModel surah;
  final VoidCallback onTap;

  const SurahCard({super.key, required this.surah, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final String iconPath = surah.revelationType == 'Meccan'
        ? Assets.imagesKaaba
        : Assets.imagesMosque;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // نحدد أحجام نسبية حسب حجم الشاشة
    final paddingH = screenWidth * 0.060;   //
    final paddingV = screenHeight * 0.0278;

    final iconSize = screenWidth * 0.07; // 7% من العرض
    final textSize = screenWidth * 0.06; // 6% من العرض
    final spacing = screenWidth * 0.08;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.03), // حوالي 12px عادي
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [AppColors.pureWhite, AppColors.primaryColor],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      surah.name,
                      style: AppTextStyles.titleStyle.copyWith(fontSize: textSize),
                    ),
                    SizedBox(width: spacing),
                    Image.asset(iconPath, width: iconSize),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.imagesNumberAya,
                    width: screenWidth * 0.08,
                  ),
                  Text(
                    surah.number.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
