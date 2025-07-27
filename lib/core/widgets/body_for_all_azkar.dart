import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'appbar_widget.dart';
import 'zikr_item.dart';

class BodyForAllAzkar extends StatelessWidget {
  const BodyForAllAzkar({
    super.key,
    required this.list,
    required this.title,
    this.specialCounts = const {},
    this.defaultCount = 1,
  });

  final List<String> list;
  final String title;
  final Map<int, int> specialCounts;
  final int defaultCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: title),
        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final itemTitle = list[index];
              final count = specialCounts[index] ?? defaultCount;

              return ZikrItem(
                title: itemTitle,
                initialCount: count,
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideX(
                begin: 0.3,
                end: 0,
                curve: Curves.easeOut,
                duration: 300.ms,
                delay: (index * 100).ms,
              );
            },
          ),
        ),
      ],
    );
  }
}
