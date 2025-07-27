import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/widgets/appbar_widget.dart';
import '../../../../../routes/routes.dart';
import '../widgets/card/services_grid.dart';
import '../widgets/dynamic_content_box.dart';
import '../widgets/sub_title.dart';
import 'date/zekr_item_list.dart';

class AllAzkarView extends StatelessWidget {
  const AllAzkarView({super.key});
  static const String routeName = Routes.AllAzkar;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            AppbarWidget(title: ' الأذكار'),

            const SizedBox(height: 12),
            //
            // const DynamicContentBox().animate()
            //     .fadeIn(duration: 200.ms)
            //     .slideX(
            //   begin: 0.3,
            //   end: 0,
            //   curve: Curves.easeInCirc,
            //   duration: 300.ms,
            // ),

            Row(
              children: [
                SubTitle(subTitle: 'زاد المسلم من الأذكار',)
              ],
            ),
            ServicesGrid(list: zekrItemList,).animate()
                .fadeIn(duration: 400.ms)
                .slideX(
              begin: 0.3,
              end: 0,
              curve: Curves.easeInCirc,
              duration: 300.ms,
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),

    );
  }
}
