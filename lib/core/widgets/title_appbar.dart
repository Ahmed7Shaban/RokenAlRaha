import 'package:flutter/material.dart';
import 'package:roken_raha/core/theme/app_text_styles.dart';

class TitleAppbar extends StatelessWidget {
  final String title;

  const TitleAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.appBarTitleStyle,
      textAlign: TextAlign.center,
    );
  }
}
