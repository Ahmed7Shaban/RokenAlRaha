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
    // احصل على أبعاد الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // استخدم قيم متناسبة مع حجم الشاشة
    final containerSize = screenWidth * 0.23; // حجم الصندوق
    final imageSize = containerSize * 0.5;    // حجم الأيقونة
    final fontSize = screenWidth * 0.035;     // حجم الخط

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: containerSize,
            height: containerSize,
            decoration: BoxDecoration(
              color: const Color(0xFFF2ECFF),
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
            child: Center(
              child: Image.asset(
                item.iconPath,
                width: imageSize,
                height: imageSize,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item.label,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4A4A4A),
                height: 1.3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
