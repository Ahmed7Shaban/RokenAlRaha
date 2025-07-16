import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roken_raha/core/theme/app_text_styles.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../date/content_box_list.dart';

class AutoSwitchingContentBox extends StatefulWidget {
  const AutoSwitchingContentBox({super.key});

  @override
  State<AutoSwitchingContentBox> createState() =>
      _AutoSwitchingContentBoxState();
}

class _AutoSwitchingContentBoxState extends State<AutoSwitchingContentBox> {
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSwitching();
  }

  void _startAutoSwitching() {
    _timer = Timer.periodic(const Duration(seconds: 6), (_) {
      setState(() {
        currentIndex = (currentIndex + 1) % ContentBoxList.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = ContentBoxList[currentIndex];

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
                image: AssetImage('assets/Images/motivasi.png'),
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
                        currentItem["title"] ?? '',
                        style: AppTextStyles.contentTitle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentItem["text"] ?? '',
                    style: AppTextStyles.contentText,
                    maxLines: null, // يسيبها مفتوحة لو النص طويل
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
