import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'استكشف مميزات ركن الراحة',
        style: AppTextStyles.sectionTitle,
        textAlign: TextAlign.right,
      ),
    );
  }
}
