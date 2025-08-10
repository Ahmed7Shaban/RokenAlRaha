import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:roken_raha/core/theme/app_colors.dart';
import 'package:roken_raha/core/widgets/appbar_widget.dart';

import '../../../../../core/ads/widgets/banner_ad_widget.dart';
import 'model/asmaa_name_model.dart';
import 'widget/detail_box.dart';

class AsmaaNameDetailView extends StatelessWidget {
  final AsmaaAllahModel model;

  const AsmaaNameDetailView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:
        [
          AppbarWidget(title: model.name).animate()
              .fadeIn(duration: 400.ms)
              .slideX(
            begin: 0.3,
            end: 0,
            curve: Curves.easeOut,
            duration: 300.ms,
          ),
          const BannerAdWidget(),


          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primaryColor,
                  child: Text(
                    "${model.id}",
                    style: const TextStyle(
                      fontSize: 25,
                      color: AppColors.pureWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ).animate()
                    .fadeIn(duration: 400.ms)
                    .slideX(
                  begin: 0.3,
                  end: 0,
                  curve: Curves.easeOut,
                  duration: 300.ms,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          DetailBox(Detail: model.text,)

        ],
      ),
    );
  }
}
