import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';

class AyaText extends StatelessWidget {
  const AyaText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'آية قرآنية لهذا اليوم',
          style: GoogleFonts.amiri(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.pureWhite,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'وَمَنْ يَتَّقِ اللَّهَ يَجْعَل لَّهُ مَخْرَجًا ۝ وَيَرْزُقْهُ مِنْ حَيْثُ لَا يَحْتَسِبُ',
          textAlign: TextAlign.center,
          style: GoogleFonts.amiri(
            color: AppColors.goldenYellow,
            fontSize: 23,
            height: 1.8,
          ),
        ),
      ],
    );
  }
}
