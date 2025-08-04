import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roken_raha/source/app_images.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../storage/ayah_like_storage.dart';
import '../../../../cubit/actionCubit/action_bottom_cubit.dart';
import '../../../../cubit/actionCubit/action_bottom_state.dart';
import '../../ayah_liked/cubit/ayah_like_cubit.dart';
import '../../ayah_liked/model/ayah_like_model.dart';

class ActionsButtons extends StatelessWidget {
  const ActionsButtons({super.key, required this.ayahShare, required this.ayahNumber, required this.surahName, required this.ayahText, required this.audioUrl});
final String ayahShare ;
final int ayahNumber ;
final String surahName ;
  final String audioUrl;


final String ayahText ;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActionBottomCubit, ActionBottomState>(
      builder: (context, state) {
        return Row(
          children: [
            _actionButton(
              imagePath: Assets.share,
              onTap: () {
                final String verse = ayahShare;
                Share.share(verse);
              },
            ),
            BlocBuilder<AyahLikeCubit, AyahLikeState>(
              builder: (context, state) {
                bool isLiked = false;

                if (state is AyahLikeLoaded) {
                  isLiked = state.likedAyahs.any(
                        (a) => a.surahName == surahName && a.ayahNumber == ayahNumber,
                  );
                }

                return _actionButton(
                  imagePath: isLiked ? Assets.liked : Assets.like,
                  onTap: () {
                    final likedAyah = AyahLikeModel(
                      ayahNumber: ayahNumber,
                      surahName: surahName,
                      ayahText: ayahText,
                    );

                    context.read<AyahLikeCubit>().toggleLike(likedAyah);
                  },
                );
              },
            ),




          ],
        );
      },
    );
  }

  Widget _actionButton({
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
