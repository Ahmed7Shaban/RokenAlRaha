// lib/features/daily_aya/view/aya_text.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../logic/aya_manager.dart';

class AyaText extends StatefulWidget {
  const AyaText({super.key});

  @override
  State<AyaText> createState() => _AyaTextState();
}

class _AyaTextState extends State<AyaText> {
  String currentAya = '';
  Timer? midnightTimer;
  final AyaManager ayaManager = AyaManager();

  @override
  void initState() {
    super.initState();
    _loadAya();
  }

  void _loadAya() async {
    currentAya = await ayaManager.getTodayAya();
    if (mounted) setState(() {});
    _scheduleMidnight();
  }

  void _scheduleMidnight() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final duration = tomorrow.difference(now);

    midnightTimer = Timer(duration, () async {
      currentAya = await ayaManager.getTodayAya();
      if (mounted) setState(() {});
      _scheduleMidnight(); // جدد المؤقت لليوم اللي بعده
    });
  }

  @override
  void dispose() {
    midnightTimer?.cancel();
    super.dispose();
  }

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
          currentAya,
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
