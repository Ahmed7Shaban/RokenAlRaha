import 'package:flutter/material.dart';
import 'package:roken_raha/core/widgets/appbar_widget.dart';

import 'dynamic_content_box.dart';
import 'card/home_services_grid.dart';
import 'sub_title.dart';

class BodyHomeView extends StatelessWidget {
  const BodyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppbarWidget(title: 'ركن الراحة'),

          const SizedBox(height: 12),

          const DynamicContentBox(),

          SubTitle(),
          HomeServicesGrid(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
