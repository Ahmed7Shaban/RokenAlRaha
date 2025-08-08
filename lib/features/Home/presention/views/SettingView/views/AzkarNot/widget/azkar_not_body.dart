import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../../../core/widgets/appbar_widget.dart';
import '../../../../widgets/card/services_grid.dart';
import '../../../../widgets/sub_title.dart';
import '../date/azkar_list.dart';

class AzkarNotBody extends StatelessWidget {
  const AzkarNotBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: "إشعارات الأذكار"),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              SubTitle(subTitle: 'ضبط الأشعارات',)
            ],
          ),
        ),
        ServicesGrid(list: AzkarList,).animate()
            .fadeIn(duration: 400.ms)
            .slideX(
          begin: 0.3,
          end: 0,
          curve: Curves.easeInCirc,
          duration: 300.ms,
        ),
        const SizedBox(height: 12),
      ],
    );  }
}
