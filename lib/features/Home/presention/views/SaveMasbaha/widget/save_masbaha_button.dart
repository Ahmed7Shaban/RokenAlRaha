import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

import '../../../../../../core/widgets/lottie_loader.dart';

  class SaveMasbahaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSaving;

  const SaveMasbahaButton({
    super.key,
    required this.onPressed,
    this.isSaving = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isSaving ? null : onPressed,
      icon: isSaving
          ? const LottieLoader(width: 30 , height:  30,)
          : const Icon(Icons.save),
      label: Lottie.asset("assets/lottie/Saved.json",width: 30,height: 30),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4,
        shadowColor: Colors.brown[300],
      ),
    );
  }
}
