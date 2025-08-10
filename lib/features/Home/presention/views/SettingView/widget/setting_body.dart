import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/ads/widgets/banner_ad_widget.dart';
import '../../../../../../core/widgets/appbar_widget.dart';
import '../../widgets/card/services_grid.dart';
import '../../widgets/sub_title.dart';
import '../date/setting_list.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: "الإعدادات"),
        const BannerAdWidget(),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SubTitle(subTitle: 'إعدادات التطبيق',)
            ],
          ),
        ),
        ServicesGrid(list: SettingList,).animate()
            .fadeIn(duration: 400.ms)
            .slideX(
          begin: 0.3,
          end: 0,
          curve: Curves.easeInCirc,
          duration: 300.ms,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
