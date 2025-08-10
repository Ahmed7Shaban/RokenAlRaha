import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/core/widgets/empty_list.dart';

import '../../../../../../core/ads/widgets/banner_ad_widget.dart';
import '../../../../../../core/widgets/appbar_widget.dart';
import '../../../../../../core/widgets/lottie_loader.dart';
import '../cubit/ayah_like_cubit.dart';
import 'ayah_liked_item.dart';

class AyahLikedBody extends StatelessWidget {
  const AyahLikedBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppbarWidget(title: "الأيات المفضلة"),
        const BannerAdWidget(),

        Expanded(
          child: BlocBuilder<AyahLikeCubit, AyahLikeState>(
            builder: (context, state) {
              if (state is AyahLikeLoaded) {
                if (state.likedAyahs.isEmpty) {
                  return EmptyList();
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: state.likedAyahs.length,
                  itemBuilder: (context, index) {
                    final ayah = state.likedAyahs[index];
                    return AyahLikedItem(
                      ayahLikeModel: ayah,
                      onDeleted: () {
                        context.read<AyahLikeCubit>().removeAyah(index);
                      },
                    );
                  },
                );
              }

              return const LottieLoader();
            },
          ),
        ),
      ],
    );
  }
}
