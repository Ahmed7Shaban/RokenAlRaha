import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roken_raha/features/Splah/presentation/widgets/aya_text.dart';

import '../../../../core/theme/app_colors.dart';
import 'nav_button.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [AyaText(), const SizedBox(height: 24), NavButton()],
        ),
      ),
    );
  }
}
