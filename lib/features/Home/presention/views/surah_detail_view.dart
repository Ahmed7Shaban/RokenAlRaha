import 'package:flutter/material.dart';
import 'package:roken_raha/core/theme/app_colors.dart';
import 'package:roken_raha/core/theme/app_text_styles.dart';

import '../../../../models/surah_model.dart';
import '../../../../routes/routes.dart';

class SurahDetailView extends StatelessWidget {
  static const String routeName = Routes.surahDetail;
  const SurahDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الفاتحة', style: AppTextStyles.appBarTitleStyle),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.pureWhite),
        toolbarHeight: 100,
      ),
    );
  }
}
