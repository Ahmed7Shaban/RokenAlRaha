import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/ads/widgets/banner_ad_widget.dart';
import '../../../../../../core/widgets/appbar_widget.dart';
import '../cubit/masbaha_cubit.dart';
import 'card_item.dart';
import 'masbaha_item_view.dart';

class MasbahaBody extends StatelessWidget {
  const MasbahaBody({
    super.key,
    required this.title,
    required this.list,
  });

  final String title;
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: title),
        const BannerAdWidget(),

        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final itemTitle = list[index];
              return CardItem(
                title: itemTitle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => MasbahaCubit(),
                        child: MasbahaItemView(title: itemTitle),
                      ),
                    ),
                  );
                },
              )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideX(
                begin: 0.3,
                end: 0,
                curve: Curves.easeOut,
                duration: 300.ms,
                delay: (index * 100).ms, // staggered animation
              );
            },
          ),
        ),
      ],
    );
  }
}
