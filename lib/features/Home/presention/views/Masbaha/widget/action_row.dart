import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roken_raha/core/theme/app_colors.dart';

import 'reset_button_animated.dart';

class ActionRow extends StatelessWidget {
  const ActionRow({
    super.key,
    required this.onIncrease,
    required this.onDecrease,
    required this.onReset,
  });

  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red[100],
                    child: IconButton(
                      icon: const Icon(Icons.remove, size: 20, color: Colors.black),
                      onPressed: onDecrease,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'نقص',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 100),

              ResetButtonAnimated(onResetWithAction: onReset),
            ],
          ),

          const SizedBox(height: 30),

          // ⬆️ زر الزيادة
          Column(
            children: [
              GestureDetector(
                onTap: onIncrease,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: const Icon(Icons.add, size: 36, color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'زيادة',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


