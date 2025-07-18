import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../routes/routes.dart';
import '../../models/surah_model.dart';
import '../../source/app_images.dart';

class SurahCard extends StatelessWidget {
  const SurahCard({super.key});

  @override
  Widget build(BuildContext context) {
    //final String iconPath = revelationType == 'مكي'
    //  ? Assets.imagesKaaba
    // : Assets.imagesMosque;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.surahDetail);
        },
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
                      'الفاتحة',
                      style: AppTextStyles.titleStyle.copyWith(fontSize: 26),
                    ),
                    const SizedBox(width: 35),
                    Image.asset(Assets.imagesKaaba, width: 30),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(Assets.imagesNumberAya, width: 40),
                  Text(
                    '1'.toString(),
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
