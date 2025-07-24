import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle titleStyle = GoogleFonts.amiri(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
  static final TextStyle appBarTitleStyle = GoogleFonts.amiri(
    fontSize: 35, // أكبر
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.3,
    letterSpacing: 0.6,
    shadows: [
      Shadow(
        offset: Offset(3, 3), // أكبر شوية
        blurRadius: 6.0, // أنعم
        color: Color(0xFFFFD700), // ذهب لامع
      ),
      Shadow(
        offset: Offset(-1, -1), // شادو خفيف في الاتجاه العكسي للعمق
        blurRadius: 2.0,
        color: Color.fromARGB(255, 2, 110, 156), // أصفر أفتح يزود اللمعة
      ),
    ],
  );

  static final contentTitle = GoogleFonts.amiri(
    color: AppColors.pureWhite,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static final contentText = GoogleFonts.amiri(
    color: AppColors.pureWhite,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.6,
  );

  static final sectionTitle = GoogleFonts.cairo(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
    height: 1.4,
    letterSpacing: 0.3,
  );

  static final ayahTextStyle = GoogleFonts.amiri(
  fontSize: 24,
  color: Colors.black,
  height: 2.3,
  fontWeight: FontWeight.bold,
  shadows: const [
  Shadow(
  color: Colors.black26,
  offset: Offset(1, 1),
  blurRadius: 2,
  ),
  ],
  );
  static const ayahNumberStyle = TextStyle(
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

} //
