import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('ركن   الراحة', style: AppTextStyles.titleStyle);
  }
}
