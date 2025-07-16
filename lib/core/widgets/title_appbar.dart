import 'package:flutter/material.dart';
import 'package:roken_raha/core/theme/app_text_styles.dart';

class TitleAppbar extends StatelessWidget {
  const TitleAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'ركن الراحة',
      style: AppTextStyles.appBarTitleStyle,
      textAlign: TextAlign.center,
    );
  }
}
