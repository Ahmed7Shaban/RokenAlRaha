import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key, required this.child});
final Widget child ;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.pureWhite, AppColors.primaryColor],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goldenYellow, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
    child: child ,);
  }
}
