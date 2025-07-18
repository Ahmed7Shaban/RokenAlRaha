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

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                      style: AppTextStyles.titleStyle.copyWith(fontSize: 26),
                    ),
                    const SizedBox(width: 35),
                    Image.asset(iconPath, width: 30),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  
                  Text(
                    surah.number.toString(),
                    style: const TextStyle(color: Colors.white),
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
