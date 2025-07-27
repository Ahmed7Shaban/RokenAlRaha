import 'package:flutter/material.dart';

import '../../source/app_images.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ContentBox extends StatelessWidget {
  const ContentBox({super.key, required this.title, required this.text});
final String title ;
final String text ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(18),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Assets.imagesMotivasi),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book,
                        color: AppColors.goldenYellow,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: AppTextStyles.contentTitle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    text ,
                    style: AppTextStyles.contentText,
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
