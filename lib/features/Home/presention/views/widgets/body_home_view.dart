import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:roken_raha/core/widgets/appbar_widget.dart';

import '../../../date/service_items_list.dart';
import 'dynamic_content_box.dart';
import 'card/services_grid.dart';
import 'sub_title.dart';

class BodyHomeView extends StatelessWidget {
  const BodyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppbarWidget(title: 'ركن الراحة'),

          const SizedBox(height: 12),

          const DynamicContentBox().animate()
              .fadeIn(duration: 200.ms)
              .slideX(
            begin: 0.3,
            end: 0,
            curve: Curves.easeInCirc,
            duration: 300.ms,
          ),

          SubTitle(subTitle: 'استكشف مميزات ركن الراحة',),
          ServicesGrid(list: serviceItemsList,).animate()
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
    );
  }
}
