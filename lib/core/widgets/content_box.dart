import 'package:flutter/material.dart';

import '../../source/app_images.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizes
    final horizontalPadding = screenWidth * 0.06; // ≈ 24
    final verticalPadding = screenHeight * 0.02;   // ≈ 16
    final contentPadding = screenWidth * 0.06;     // ≈ 24
    final iconSize = screenWidth * 0.05;           // ≈ 20
    final titleFontSize = screenWidth * 0.045;     // ≈ 16-18
    final textFontSize = screenWidth * 0.04;       // ≈ 14-16

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(screenWidth * 0.045),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Assets.imagesMotivasi),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(contentPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book,
                        color: AppColors.goldenYellow,
                        size: iconSize,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        title,
                        style: AppTextStyles.contentTitle.copyWith(
                          fontSize: titleFontSize,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    text,
                    style: AppTextStyles.contentText.copyWith(
                      fontSize: textFontSize,
                    ),
                    maxLines: null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
