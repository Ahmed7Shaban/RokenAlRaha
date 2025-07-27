import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';

class SubTitle extends StatelessWidget {
  const SubTitle({super.key, required this.subTitle});
final String subTitle ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Text(
        subTitle ,
        style: AppTextStyles.sectionTitle,
        textAlign: TextAlign.right,
      ),
    );
  }
}
