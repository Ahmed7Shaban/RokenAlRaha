import 'package:flutter/material.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

import '../theme/app_text_styles.dart';

class AyahText extends StatelessWidget {
  const AyahText({super.key, required this.ayahText});
final String ayahText;
  @override
  Widget build(BuildContext context) {
    return    Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldenYellow,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.black12),
      ),
      child: Text(
        ayahText,
        textAlign: TextAlign.right,
        style: AppTextStyles.ayahTextStyle,

        textDirection: TextDirection.rtl,
      ),
    );
  }
}
