import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'title_appbar.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(70),
          bottomRight: Radius.circular(70),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Center(child: TitleAppbar(title: title)),
      ),
    );
  }
}
