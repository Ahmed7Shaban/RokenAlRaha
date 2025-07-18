import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/service_item.dart';

class CardServices extends StatelessWidget {
  final ServiceItem item;
  final int index;
  final VoidCallback onTap;

  const CardServices({
    super.key,
    required this.item,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFF2ECFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Image.asset(item.iconPath, width: 50, height: 50),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A4A4A),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
